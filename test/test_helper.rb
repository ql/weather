ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/autorun"

DatabaseCleaner.strategy = :truncation
class MiniTest::Spec
  before :each do
    DatabaseCleaner.clean
  end
end
