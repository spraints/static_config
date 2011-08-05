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
        data = YAML.load_file(@file) if File.exists? @file
        data = data[@section] if data && @section
        data
      end
    end
  end
end
