require File.expand_path('../boot', __FILE__)

#require 'rails/all'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
#require 'active_resource/railtie'
#require 'rails/test_unit/railtie'

# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, Rails.env

module Culini
  class Application < Rails::Application
    # Add additional load paths for your own custom dirs
    config.autoload_paths += %W( #{config.root}/app/workers #{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.active_record.timestamped_migrations = false
    config.active_record.include_root_in_json = false

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :de

    config.action_mailer.template_root = "app/views/mailers"

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec, :fixture => false
    end

   # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    config.action_view.javascript_expansions[:jquery] = 'http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js', 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js'

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password

    # Enable IdentityMap for Active Record, to disable set to false or remove the line below.
    config.active_record.identity_map = true

    # Enable the asset pipeline
    config.assets.enabled = true

  end
end
