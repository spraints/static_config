module StaticConfig
  module Reader
    class Base
      class << self
        def read(opts = {})
          new(opts).read
        end
      end

      def initialize(opts = {})
        @prefix = opts[:prefix]
      end

      def read
        fixup(raw_data || {})
      end

      protected
      def fixup(data)
        if @prefix
          prefix_parts = @prefix.split(/\./)
          data = prefix_parts.reverse.inject(data) { |res, part| {part => res} }
        end
        data
      end
    end
  end
end
