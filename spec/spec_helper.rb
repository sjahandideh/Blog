# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# capybara setup
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  # filters
  config.filter_run_including demo: true

  # database cleaner setup
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    #DatabaseCleaner.clean_with(:transaction)
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before :type => :feature do
    DatabaseCleaner.strategy = :deletion
  end

  config.after :type => :feature do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

# irake setup -- using rake inside specs
require 'irake'
RSpec.configuration.include IRB::ExtendCommandBundle
