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
          last_part = parts.pop
          parts.inject(data) { |h, k| h[k] ||= {} }[last_part] = env_value
        end
        data
      end
    end
  end
end
