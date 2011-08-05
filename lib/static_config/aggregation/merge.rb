module StaticConfig
  module Aggregation
    class Merge
      def initialize(readers)
        @readers = readers
      end

      def read
        @readers.inject({}) { |res, reader| deep_merge res, reader.read }
      end

      private
      def deep_merge base, overrides
        overrides.inject(base.dup) { |res, (key, value)|
          res[key] =
            if res[key].is_a?(Hash) && value.is_a?(Hash)
              deep_merge res[key], value
            else
              value
            end
          res
        }
      end
    end
  end
end
