# Rails-jqtouch
require File.dirname(__FILE__) + '/hash_extensions'
require File.dirname(__FILE__) + '/iphone_controller'
require File.dirname(__FILE__) + '/configuration_helper'
require File.dirname(__FILE__) + '/mobile_helper'

#Hash.send(:include, Jqtouch::HashExtensions)
ActionController::Base.send(:include, Jqtouch::IphoneController)
ActionView::Base.send(:include, Jqtouch::ConfigurationHelper)
ActionView::Base.send(:include, Jqtouch::MobileHelper)
# Mime Type iphone como alias de text/html
Mime::Type.register_alias "text/html", :iphone
