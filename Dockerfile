# syntax=docker/dockerfile:1

ARG RUBY_VERSION
ARG DISTRO_NAME=bullseye

FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME as base

ARG DISTRO_NAME
ARG PG_MAJOR

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  curl \
  less \
  git \
  vim \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Install PostgreSQL dependencies
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt/" \
    $DISTRO_NAME-pgdg main $PG_MAJOR | tee /etc/apt/sources.list.d/postgres.list > /dev/null
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

ENV APP_HOME /rails-app
WORKDIR $APP_HOME
COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install
COPY . $APP_HOME

EXPOSE 3000
# Use Bash as the default command
CMD ["/bin/bash"]


# The production-builder image is responsible for installing dependencies and compiling assets
FROM base as production-builder

# First, we create and configure a dedicated user to run our application
RUN groupadd --gid 1005 rails_user \
  && useradd --uid 1005 --gid rails_user --shell /bin/bash --create-home rails_user
USER rails_user
RUN mkdir /home/rails_user/rails-app
WORKDIR /home/rails_user/rails-app

# Then, we re-configure Bundler
ENV RAILS_ENV=production \
  LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 \
  BUNDLE_APP_CONFIG=/home/rails_user/bundle \
  BUNDLE_PATH=/home/rails_user/bundle \
  GEM_HOME=/home/rails_user/bundle

# Install Ruby gems
COPY --chown=rails_user:rails_user Gemfile Gemfile.lock ./
RUN mkdir $BUNDLE_PATH \
  && bundle config --local deployment 'true' \
  && bundle config --local path "${BUNDLE_PATH}" \
  && bundle config --local without 'development test' \
  && bundle config --local clean 'true' \
  && bundle config --local no-cache 'true' \
  && bundle install --jobs=${BUNDLE_JOBS} \
  && rm -rf $BUNDLE_PATH/ruby/$RUBY_VERSION/cache/* \
  && rm -rf /home/rails_user/.bundle/cache/*

# Install JS packages
COPY --chown=rails_user:rails_user package.json yarn.lock ./
RUN yarn install --check-files

# Copy code
COPY --chown=rails_user:rails_user . .

# Precompile assets
# NOTE: The command may require adding some environment variables (e.g., SECRET_KEY_BASE) if you're not using
# credentials.
RUN bundle exec rails assets:precompile

# Finally, our production image definition
# NOTE: It's not extending the base image, it's a new one
FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME AS production

# Production-only dependencies
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  apt-get update -qq \
  && apt-get dist-upgrade -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    curl \
    gnupg2 \
    less \
    tzdata \
    time \
    locales \
  && update-locale LANG=C.UTF-8 LC_ALL=C.UTF-8

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system && \
    gem install bundler

# Create and configure a dedicated user (use the same name as for the production-builder image)
RUN groupadd --gid 1005 rails_user \
  && useradd --uid 1005 --gid rails_user --shell /bin/bash --create-home rails_user
RUN mkdir /home/rails_user/app
WORKDIR /home/rails_user/app
USER rails_user

# Ruby/Rails env configuration
ENV RAILS_ENV=production \
  BUNDLE_APP_CONFIG=/home/rails_user/bundle \
  BUNDLE_PATH=/home/rails_user/bundle \
  GEM_HOME=/home/rails_user/bundle \
  PATH="/home/rails_user/app/bin:${PATH}" \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

EXPOSE 3000

# Copy code
COPY --chown=rails_user:rails_user . .

# Copy artifacts
# 1) Installed gems
COPY --from=production-builder $BUNDLE_PATH $BUNDLE_PATH
# 2) Compiled assets (by Webpacker in this case)
COPY --from=production-builder /home/rails_user/app/public/packs /home/rails_user/app/public/packs
# 3) We can even copy the Bootsnap cache to speed up our Rails server load!
COPY --chown=rails_user:rails_user --from=production-builder /home/rails_user/app/tmp/cache/bootsnap* /home/rails_user/app/tmp/cache/

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
