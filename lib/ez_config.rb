class EzConfig
  class NoConfigForEnv < StandardError; end

  PRODUCTION_REGEX  = /^production/

  def initialize(opt)
    @env              = opt[:env].to_s
    @path             = opt[:path]
    @production_regex = opt[:production_regex] || PRODUCTION_REGEX
  end

  def [](k)
    config[k]
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
end
