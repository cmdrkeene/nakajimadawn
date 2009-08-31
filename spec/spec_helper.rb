require 'rubygems'
require 'spork'
require 'fakeweb'
ENV["RAILS_ENV"] = 'test'
 
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  
  # This file is copied to ~/spec when you run 'ruby script/generate rspec'
  # from the project root directory.
  require File.dirname(__FILE__) + "/../config/environment"
  require 'spec/autorun'
  require 'spec/rails'
  require "factory_girl"
  
  FakeWeb.allow_net_connect = false
 
  Spec::Runner.configure do |config|
    # If you're not using ActiveRecord you should remove these
    # lines, delete config/database.yml and disable :active_record
    # in your config/boot.rb
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
 
    # == URLS
    
    # user_timeline/bancroftdoorman
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/bancroftdoorman.json?page=1&count=200",
                         :body => File.read(File.dirname(__FILE__) + '/fixtures/user_timeline/bancroftdoorman.json'))
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/bancroftdoorman.json?page=2&count=200",
                         :body => "[]")
                         
    # user_timeline/nakajima
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/nakajima.json?page=1&count=200",
                         :body => File.read(File.dirname(__FILE__) + '/fixtures/user_timeline/nakajima_page_1.json'))
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/nakajima.json?page=2&count=200",
                         :body => File.read(File.dirname(__FILE__) + '/fixtures/user_timeline/nakajima_page_2.json'))
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/nakajima.json?page=3&count=200",
                         :body => "[]")
    FakeWeb.register_uri(:get,
                         "http://twitter.com/statuses/user_timeline/nakajima.json?page=1&count=200&since_id=3640288039",
                         :body => File.read(File.dirname(__FILE__) + '/fixtures/user_timeline/nakajima_since_id_3640288039.json'))
  end
 
end
 
Spork.each_run do
  # This code will be run each time you run your specs.
  
  require RAILS_ROOT + "/spec/factories"
end