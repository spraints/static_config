require 'static_config/configurer'

module StaticConfig
  class << self
    def build(&block)
      config = Configurer.new
      config.instance_eval(&block)
      config.build
    end
  end
end
