module StaticConfig
  class ConfigHash
    def initialize(data)
      @data = data
    end

    def method_missing(attr, *args)
      case value = @data[attr.to_s]
      when Hash
        ConfigHash.new value
      else
        value
      end
    end

    def ==(other)
      super || @data == other
    end
  end
end
