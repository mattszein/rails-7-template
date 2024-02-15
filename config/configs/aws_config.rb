# This file is used as an example of how to use the AwsConfig to create a configuration file
class AwsConfig < ApplicationConfig
  attr_config :access_key_id, :secret_access_key, :region, :storage_bucket
end
