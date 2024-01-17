class Adminit::AuthorizationSettings
  def self.configuration
    {
      "adminit/application": {
        manage?: [1, 2, 3]
      },
      "adminit/role": {
        manage?: [1, 2],
        remove_user?: [1, 2]
      }
    }
  end

  def self.get(controller_name, key)
    find = configuration.dig(controller_name, key)
    return find unless find.nil?
    default
  end

  def self.default
    configuration.dig(:"adminit/application", :manage?)
  end
end
