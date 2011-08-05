module StaticConfig
  class ConfigHash < Hash
    def initialize(data)
      replace(data)
    end

    def method_missing(attr)
      case value = self[attr.to_s]
      when Hash
        self.class.new(value)
      else
        value
      end
    end
  end
end
