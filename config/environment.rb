# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Preferences
@@preference = {}

Rails::Initializer.run do |config|

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  config.active_record.observers = :person_observer
  config.gem 'bluecloth', :version => '>= 2.0.0'
end

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto   => true,
  :address                => "smtp.gmail.com",
  :port                   => 587,
  :domain                 => "thehealthier.me",
  :authentication         => :login,
  :user_name              => "mike@thehealthier.me",
  :password               => "rastA21man"
}