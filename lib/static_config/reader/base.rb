module StaticConfig
  module Reader
    class Base
      class << self
        def read(opts = {})
          new(opts).read
        end
      end

      def initialize(opts = {})
      end

      def read
        raw_data || {}
      end
    end
  end
end
