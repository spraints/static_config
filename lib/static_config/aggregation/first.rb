module StaticConfig
  module Aggregation
    class First
      def initialize(readers)
        @readers = readers
      end

      def read
        @readers.inject(nil) { |res, reader| res || empty_to_nil(reader.read) } || {}
      end

      private
      def empty_to_nil(hash)
        if hash && hash.size > 0
          hash
        else
          nil
        end
      end
    end
  end
end
