require 'test_helper'

class MobileHelperTest < ActionView::TestCase
  tests Jqtouch::MobileHelper
    
  test "mobile page" do
    div = 
      mobile_page("home", :selected => true) do
        content_tag(:h1, "Home Page")
      end
    
    expected = 
      '<div id="home" selected="true">' +
      '<h1>Home Page</h1>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile pad" do
    div = 
      mobile_pad(:class => "pointless_class") do
        content_tag(:h1, "Home Page")
      end
    
    expected = 
      '<div class="pad pointless_class">' +
      '<h1>Home Page</h1>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile panel" do
    div = 
      mobile_panel("home") do
        content_tag(:h1, "Home Page")
      end
    
    expected = 
      '<div class="panel" id="home">' +
      '<h1>Home Page</h1>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile panel with extra class" do
    div = 
      mobile_panel("home", :class => "pointless_class") do
        content_tag(:h1, "Home Page")
      end
    
    expected = 
      '<div class="panel pointless_class" id="home">' +
      '<h1>Home Page</h1>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile fieldset" do
    fieldset = 
      mobile_fieldset(:class => "pointless_class") do
        content_tag(:h1, "Home Page")
      end
    
    expected = 
      '<fieldset class="pointless_class">' +
      '<h1>Home Page</h1>' +
      '</fieldset>'

    assert_equal(expected, fieldset)
  end
  
  test "mobile row" do
    row = 
      mobile_row("Name") do
        content_tag(:span, "My Name")
      end
    
    expected = 
      '<div class="row">' +
      '<label>Name</label>' +
      '<span>My Name</span>' +
      '</div>'

    assert_equal(expected, row)
  end
  
  test "mobile row with class" do
    row = 
      mobile_row("Name", :class => 'pointless_class') do
        content_tag(:span, "My Name")
      end
    
    expected = 
      '<div class="row pointless_class">' +
      '<label>Name</label>' +
      '<span>My Name</span>' +
      '</div>'

    assert_equal(expected, row)
  end
  
  test "mobile row without block" do
    row = mobile_row("Name")
    expected = '<div class="row"><label>Name</label></div>'
    assert_equal(expected, row)
  end
  
  test "mobile toolbar" do
    tb = 
      mobile_toolbar("Home") do
        content_tag(:h2, "Sweet Home")
      end
    
    expected = 
      '<div class="toolbar">' +
      '<h1>Home</h1>' +
      '<h2>Sweet Home</h2>' +
      '</div>'

    assert_equal(expected, tb)
  end
  
  test "mobile page with toolbar" do
    div = 
      mobile_page_with_toolbar("JQ Touch", :selected => true) do
        content_tag(:h2, "Sweet Home")
      end
    
    expected = 
      '<div id="jq_touch" selected="true">' +
      '<div class="toolbar">' +
      '<h1>JQ Touch</h1>' +
      '</div>' +
      '<h2>Sweet Home</h2>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile page with toolbar and back button" do
    div = 
      mobile_page_with_toolbar("JQ Touch", :selected => true, :back_button => "Volver") do
        content_tag(:h2, "Sweet Home")
      end
    
    expected = 
      '<div id="jq_touch" selected="true">' +
      '<div class="toolbar">' +
      '<h1>JQ Touch</h1>' +
      '<a href="#" class="button back">Volver</a>' +
      '</div>' +
      '<h2>Sweet Home</h2>' +
      '</div>'

    assert_equal(expected, div)
  end
  
  test "mobile toolbar with back button" do
    tb = 
      mobile_toolbar("Home", :back_button => "Volver") do
        content_tag(:h2, "Sweet Home")
      end
    
    expected = 
      '<div class="toolbar">' +
      '<h1>Home</h1>' +
      '<h2>Sweet Home</h2>' +
      '<a href="#" class="button back">Volver</a>' +
      '</div>'

    assert_equal(expected, tb)
  end
  
  test "mobile list item" do
    li = mobile_list_item :name => "Test Item", :url => "#test_item"
    expected = '<li><a href="#test_item">Test Item</a></li>'
    assert_equal(expected, li)
  end
  
  test "mobile list item with effect" do
    li = mobile_list_item({:name => "Test Item", :url => "#test_item"}, :effect => "flip")
    expected = '<li><a href="#test_item" class="flip">Test Item</a></li>'
    assert_equal(expected, li)
  end
  
  test "mobile list item with effect and target" do
    li = mobile_list_item({:name => "Test Item", :url => "#test_item", :target => "_blank"}, :effect => "flip")
    expected = '<li><a href="#test_item" class="flip" target="_blank">Test Item</a></li>'
    assert_equal(expected, li)
  end
  
  test "mobile list item should raise" do
    assert_raise(RuntimeError) { mobile_list_item({}) }
  end
  
  test "mobile list" do
    items = [
      {:name => "Test Item", :url => "#test_item"},
      {:name => "Test Item 2", :url => "#test_item2", :target => "_self"}]
      
    list = mobile_list(items, :effect => "flip")
    
    expected = 
      '<ul class="edgetoedge">' +
      '<li><a href="#test_item" class="flip">Test Item</a></li>' +
      '<li><a href="#test_item2" class="flip" target="_self">Test Item 2</a></li>' +
      '</ul>'
      
    assert_equal(expected, list)
  end
  
  test "mobile button" do
    button = mobile_button_to("About", "#about", :class => "leftButton", :effect => "flip")
    expected = '<a href="#about" class="button leftButton flip">About</a>'
    assert_equal(expected, button)  
  end
  
  test "mobile back button" do
    button = mobile_back_button "Volver"
    expected = '<a href="#" class="button back">Volver</a>'
    assert_equal(expected, button)  
  end
  
  test "mobile back button with class" do
    button = mobile_back_button "Volver", :class => "greyButton"
    expected = '<a href="#" class="button back greyButton">Volver</a>'
    assert_equal(expected, button)  
  end
  
end
