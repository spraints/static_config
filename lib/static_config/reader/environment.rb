require 'static_config/reader/base'

module StaticConfig
  module Reader
    class Environment < Base
      def initialize(opts = {})
        super
        @env_prefix = opts[:env_prefix]
      end

      protected
      def raw_data
        ENV.inject({}) { |res, (name, value)| update(res, name, value) }
      end

      def update(data, env_name, env_value)
        if env_name =~ /^#{@env_prefix}_(.*)/
          parts = $1.downcase.split(/_/)
          value = convert(env_value)
          build(data, parts, value)
        end
        data
      rescue => e
        raise "Unable to fit #{env_name} into #{data.inspect}"
      end

      def build(data, keys, value)
        first, *rest = keys
        while !rest.empty?
          build(data[first] ||= {}, rest, value)
          first += '_' + rest.shift
        end
        data[first] = value
      end

      def convert env_value
        case env_value
        when /^\d+$/
          env_value.to_i
        when /^(\d*\.\d+)|(\d+\.\d*)$/
          env_value.to_f
        when 'true'
          true
        when 'false'
          false
        else
          env_value
        end
      end
    end
  end
end
