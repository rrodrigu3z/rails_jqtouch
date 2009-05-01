$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "test/unit"
require "rubygems"
require "active_support"
require "hash_extensions"

class HashExtensionsTest < Test::Unit::TestCase
  def setup
    @h = {:camel_case => 1}
  end
  
  def test_camelize_keys_upper
    assert_equal({"CamelCase" => 1}, @h.camelize_keys!)
  end
  
  def test_camelize_keys_lower
    assert_equal({"camelCase" => 1}, @h.camelize_keys!(:lower))
  end
end
