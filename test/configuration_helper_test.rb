require 'test_helper'

class ConfigurationHelperTest < ActionView::TestCase
  tests Jqtouch::ConfigurationHelper
    
  test "jqtouch init" do
    js = <<-EOF
<script charset="utf-8" type="text/javascript">
//<![CDATA[
var jQT = new $.jQTouch({"statusBar":"black-translucent"});
//]]>
</script>
    EOF

    assert_equal(js.strip, jqtouch_init(:status_bar => 'black-translucent'))
  end
  
  test 'jqtouch init sin args' do
    js = <<-EOF
<script charset="utf-8" type="text/javascript">
//<![CDATA[
var jQT = new $.jQTouch({});
//]]>
</script>
    EOF
    
    assert_equal(js.strip, jqtouch_init)
  end
end
