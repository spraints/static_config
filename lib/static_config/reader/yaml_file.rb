require 'static_config/reader/base'
require 'yaml'

module StaticConfig
  module Reader
    class YamlFile < Base
      def initialize(opts = {})
        super
        @file = opts[:file]
        @section = opts[:section]
      end

      protected
      def raw_data
        data = YAML.load_file(@file)
        data = data[@section] if @section
        data
      end
    end
  end
end
