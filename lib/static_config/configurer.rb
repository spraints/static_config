require 'static_config/config_proxy'
require 'static_config/aggregation/merge'
require 'static_config/aggregation/first'
require 'static_config/reader/environment'
require 'static_config/reader/yaml_env'
require 'static_config/reader/yaml_file'

module StaticConfig
  class Configurer
    def build
      ConfigProxy.new StaticConfig::Aggregation::Merge.new(self.readers)
    end
    def first(&block)
      push_readers do
        instance_eval(&block)
        add StaticConfig::Aggregation::First.new self.readers
      end
    end
    def env(var_prefix)
      add StaticConfig::Reader::Environment.new(:env_prefix => var_prefix)
    end
    def env_yaml(var_name)
      add StaticConfig::Reader::YamlEnv.new(:env => var_name)
    end
    def file(path, opts={})
      add StaticConfig::Reader::YamlFile.new(opts.merge(:file => path))
    end
    def add(reader)
      readers << reader
    end
    def push_readers
      old_readers, self.readers = self.readers, []
      yield
    ensure
      self.readers = old_readers
    end
    def readers
      @readers ||= []
    end
    attr_writer :readers
  end
end
