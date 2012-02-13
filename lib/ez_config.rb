class EzConfig
  class NoConfigForEnv < StandardError; end

  PRODUCTION_REGEX  = /^production/

  class << self
    def configure(opt)
      @opt = opt
    end

    def instance
      @instance ||= new (@opt || {})
    end

    def [](k)
      instance[k]
    end

    def to_hash
      instance.to_hash
    end
  end

  def initialize(opt={})
    @env              = opt[:env].to_s || ENV['RACK_ENV'] || ENV['RAILS_ENV']
    @path             = opt[:path] || "#{Dir.pwd}/config/app_config"
    @production_regex = opt[:production_regex] || PRODUCTION_REGEX
  end

  def [](k)
    to_hash[k]
  end

  def files
    Dir.glob File.join(@path, '*.yml')
  end

  def default_env
    @env =~ @production_regex ? 'production' : 'non_production'
  end

  def config
    @config ||= files.inject({}) do |config, file|
      key   = File.basename file, '.yml'
      yaml  = YAML.load_file file
      val   = yaml[@env] || yaml[default_env]

      raise NoConfigForEnv, "Environment #{@env} not found in #{file}" unless val

      config[key] = val
      config
    end
  end

  alias :to_hash :config
end
