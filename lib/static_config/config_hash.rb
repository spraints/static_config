module StaticConfig
  class ConfigHash
    def initialize(data)
      @data = data
    end

    def method_missing(attr, *args)
      if value = @data[attr.to_s]
        if value.is_a? Hash
          ConfigHash.new value
        else
          value
        end
      else
        nil
      end
    end

    def ==(other)
      super || @data == other
    end
  end
end
