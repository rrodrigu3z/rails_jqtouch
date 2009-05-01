$:.unshift(File.dirname(__FILE__) + '/../lib')

ENV["RAILS_ENV"] = "test"
require File.dirname(__FILE__) + '/../../../../config/environment'
require 'test_help'

require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'action_view/test_case'
