ez_config
=========

This gem can load your yaml configuration files from a specified path.


The idea behind this type of configuration is a similar concept to the
traditional database.yml file found in Rails applications. This file specifies
all environments for a service in one file, instead of all services for an
environment in one file.

Install
--------

Terminal:

```
gem install ez_config
```

Bundler:

```ruby
gem 'ez_config'
```

Usage
-----

The following example creates a new `EzConfig` object and loads all configurations
from your applications `config` directory. Obviously you can use this gem in any
ruby project, and it is not rails specific.

```ruby
@config = EzConfig.new({
  :env          => Rails.env,
  :path         => "#{Rais.root}/config"
})
```

To configure a new service called `new_service`, you will create a YML file in
your config direcotry. The file has to have an extension of `.yml`. The name of
the file will become the config key. This file has to contain at least two
environments, `production` and `non_production`:

```yaml
non_production:
  uri: http://dev.path.to.new.service
  something: else

production:
  uri: http://path.to.new.service
  something: else
```

After this file has been created, access to it can be obtained by doing:

```ruby
@config['new_service']
# {'uri' => 'http://path.to.new.service', 'something' => 'else'}
```

By the fault if your `env` name does not start with `production` and is not specified in
your yaml file, EzConfig will load the default `non_production` env. If your `env`
name starts with `production`( e.g. `production-1` ), and is not specified in your yaml
file, it will load the default `production` env. This simplifies configuration for large
projects that may have many a dozen different environments.

Lastly, if your cretiria in recognizing `production` and `production` environments differs
from the default, you can pass in `:production_regex` to specify your own cretieria.
The example below determins whether to use `production` or `non_production` configurations
by checking if current environment ends with `-prod`

```ruby
@config = EzConfig.new({
  :env          => Rails.env,
  :path         => "#{Rais.root}/config",
  :production_regex => /-prod$/
})
```

Contributing to ez_config
-------------------------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2012 Aaron Qian, Adam Avilla. See LICENSE.txt for
further details.

