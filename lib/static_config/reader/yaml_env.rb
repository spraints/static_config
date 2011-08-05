require 'static_config/reader/base'
module StaticConfig
  module Reader
    class YamlEnv < Base
      def initialize(opts = {})
        super
        @env = opts[:env]
      end

      protected
      def raw_data
        YAML.load(ENV[@env])
      end
    end
  end
end
