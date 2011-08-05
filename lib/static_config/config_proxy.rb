require 'static_config/config_hash'

module StaticConfig
  class ConfigProxy
    def initialize(reader)
      @reader = reader
    end

    def method_missing(*args)
      config.send(*args)
    end

    def config
      @config ||= ConfigHash.new @reader.read
    end

    def reload!
      @config = nil
    end
  end
end
