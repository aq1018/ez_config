require 'spec_helper'

describe EzConfig do
  def ez_config(env)
    EzConfig.new({
      :env  => env,
      :path => File.join(File.dirname(__FILE__), 'config')
    })
  end

  it "should load all configs" do
    config = ez_config(:test)
    config['foo'].should_not be_empty
    config['bar'].should_not be_empty
  end

  it "should load default non_production configurations" do
    config = ez_config(:test)
    config['foo']['foo_path'].should == '/path/to/dev'
  end

  it "should load default production configurations" do
    config = ez_config(:production_japan)
    config['foo']['foo_path'].should == '/path/to/prod'
  end

  it "should load specific configurations" do
    config = ez_config(:production_west_coast)
    config['foo']['foo_path'].should == '/path/to/prod_west'
  end
end
