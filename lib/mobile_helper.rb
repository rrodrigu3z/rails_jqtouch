module Jqtouch
  
  # Helpers para generar los diversos elementos que componen las vistas destinadas a las respuestas
  # de los navegadores Mobile Safari, de acuerdo a los estilos y markup especificados en jQTouch.
  #
  # Dentro del conjunto de elementos que se pueden generar se encuentran:
  # * page
  # * pad
  # * panel
  # * fieldset
  # * row
  # * toolbar
  # * button
  # * list
  # * TODO: grouped list
  #
  # Ejemplo (extracto del ejemplo index.html de jQTouch):
  #
  #   <% mobile_page 'home', :selected => true do  %>
  #   <% mobile_toolbar 'jQTouch' do %>
  #     <%= mobile_button_to "About", '#about', :effect => 'slideup' %>
  #   <% end %>
  # 
  #   <%= mobile_list [
  #       {:name => "Features", :url => "#features", :count => 3, :icon => "arrow"},
  #       {:name => "Demos", :url => "#demos"},
  #       {:name => "Docs", :url => "docs.html"},
  #       {:name => "License", :url => "#license"},
  #       {:name => "Download &raquo;", :url => "http://www.jqtouch.com/", :target => "_self"} ]  %>
  #
  #   <% end %>
  #
  #   <% mobile_info_section do %>
  #     <p>Add this page to your home screen to view the custom icon, startup screen, and full screen mode.</p>
  #   <% end -%>
  #
  # TODO: Eliminar helpers viejos ya no compatibles con la versión actual.
  module MobileHelper
    
    # Genera el wrapper para una página, referenciada por un id. Ejemplo de uso:
    #
    #   mobile_page("home", :selected => true) do
    #     content_tag(:h1, "Home Page")
    #   end
    #
    # Genera:
    #
    #   <div id="home" selected="true">
    #     <h1>Home Page</h1>
    #   </div>
    def mobile_page(id, options = {}, &proc)
      raise "Proc needed" unless block_given?
      concat build_page(id, options, &proc)
    end
    
    # Genera un +div+ con la clase *pad*, que sirve de contenedor de elementos de formulario, texto,
    # entre otros. Se pueden especificar opciones html en +options+. Si se especifica +:class+ dentro
    # de las opciones, esta es agregada a "pad". Ejemplo:
    #
    #   mobile_pad(:class => "pointless_class") do
    #     content_tag(:h1, "Home Page")
    #   end
    #
    # Lo cual genera:
    #
    #   <div class="pad pointless_class">
    #     <h1>Home Page</h1>
    #   </div>
    def mobile_pad(options = {}, &proc)
      raise "Proc needed" unless block_given?
      options[:class] = options.has_key?(:class) ? "pad #{options[:class]}" : "pad"
      concat content_tag(:div, capture(&proc), options)
    end
    
    # Es como +mobile_page+, pero le agrega al div resultante la clase +panel+. Ejemplo
    #
    #   mobile_panel("home", :class => "pointless_class") do
    #     content_tag(:h1, "Home Page")
    #   end
    #
    # Lo cual genera:
    #
    #   <div class="panel pad pointless_class" id="home">
    #     <h1>Home Page</h1>
    #   </div>
    def mobile_panel(id, options = {}, &proc)
      options[:class] = options.has_key?(:class) ? "panel #{options[:class]}" : "panel"
      mobile_page id, options, &proc
    end
    
    # Genera un +div+ con la clase *info*, que sirve para mostrar trexto informativo.
    # Se pueden especificar opciones html en +options+. Si se especifica +:class+ dentro
    # de las opciones, esta es agregada a "info". Ejemplo:
    #
    #   mobile_info_section(:class => "pointless_class") do
    #     content_tag(:p, "Este es un texto de información irrelevante")
    #   end
    #
    # Lo cual genera:
    #
    #   <div class="info pointless_class">
    #     <p>Este es un texto de información irrelevante</p>
    #   </div>
    def mobile_info_section(options = {}, &proc)
      raise "Proc needed" unless block_given?
      options[:class] = options.has_key?(:class) ? "info #{options[:class]}" : "info"
      concat content_tag(:div, capture(&proc), options)
    end
    
    # Genera un +fieldset+, que sirve de contenedor de elementos de formulario (en la pråctica 
    # contendría varios +mobile_row+). Se pueden especificar opciones html en +options+. Ejemplo:
    #
    #   mobile_fieldset(:class => "pointless_class") do
    #     content_tag(:span, "Field")
    #   end
    #
    # Lo cual genera:
    #
    #   <fieldset class="pointless_class">
    #     <span>Field</span>
    #   </fieldset>
    def mobile_fieldset(options = {}, &proc)
      raise "Proc needed" unless block_given?
      concat content_tag(:fieldset, capture(&proc), options)
    end
  
    # Genera un +div+, con la clase +row+ que sirve de contenedor de elementos de formulario. +name+
    # especifica la etiqueta del campo del formulario. Se pueden especificar opciones html en 
    # +options+. Ejemplo:
    #
    #   mobile_row("Name", :class => "pointless_class") do
    #     content_tag(:span, "Dummy Field")
    #   end
    #
    # Lo cual genera:
    #
    #   <div class="row pointless_class">
    #     <label>Field</label>
    #     <span>Dummy Field</span>
    #   </div>
    #
    # También puede utilizarse sin bloque: Ejemplo:
    #
    #   mobile_row "Name"
    #
    # Lo que genera el siguiente HTML:
    #
    #   <div class="row">
    #     <label>Field</label>
    #   </div>
    def mobile_row(name=nil, options = {}, &proc)
      options[:class] = options.has_key?(:class) ? "row #{options[:class]}" : "row"
      label = name ? content_tag(:label, name) : ""
      if block_given?
        concat content_tag(:div, label + capture(&proc), options)
      else
        content_tag(:div, label, options)
      end
    end
    
    # Permite genrar la barra de herramientas (toolbar), con el título especificado por +title+, y el
    # contenido mediante un bloque. +options+, por ahora, acepta la opción +:back_button+, la cual
    # permite agregar un botón para regresar (Back Button) con el nombre especificado. Ejemplo:
    #
    #   mobile_toolbar("Home", :back_button => "Volver") do
    #     content_tag(:h2, "Sweet Home")
    #   end
    #
    # Genera el siguiente HTML:
    #
    #   <div class="toolbar">
    #     <h1>Home</h1>
    #     <h2>Sweet Home</h2>
    #     <a href="#" class="button back">Volver</a>
    #   </div>
    def mobile_toolbar(title, options={}, &proc)
      raise "Proc needed" unless block_given?
      concat build_toolbar(title, options, &proc)
    end
    
    # Genera una página (tipo +mobile_page+), con un +mobile_toolbar+ de manera automática. El título
    # en el toolbar es especificado por +title+, y el id de la página (por defecto, si no se 
    # especifica +:id+ en +options+) es +title+ en la forma *underscore* (los espacios en +title+
    # son reemplazados por underscore también).
    #
    # Ejemplo:
    #
    #   mobile_page_with_toolbar("JQ Touch", :selected => true, :back_button => "Volver") do
    #     content_tag(:h2, "Sweet Home")
    #   end
    #
    # Genera:
    #
    #   <div id="jq_touch" selected="true">
    #     <div class="toolbar">
    #       <h1>JQ Touch</h1>
    #       <a href="#" class="button back">Volver</a>
    #     </div>
    #     <h2>Sweet Home</h2>
    #   </div>
    def mobile_page_with_toolbar(title, options={}, &proc)
      raise "Proc needed" unless block_given?
      id = options.delete(:id) || title.gsub(" ", "_").underscore
      toolbar = build_toolbar(title, options)
      concat build_page(id, options, toolbar, &proc)
    end
    
    # Genera un botón (link con la clase *button*), que contiene adicionalmente la clase *back*.
    # Ejemplo:
    #
    #   mobile_back_button "Volver" 
    #   
    # Genera:
    #
    # <a href="#" class="button back">Volver</a>
    def mobile_back_button(name, html_options = {})
      html_options[:class] = html_options.has_key?(:class) ? "back #{html_options[:class]}" : "back"
      mobile_button_to(name, "#", html_options)
    end
    
    # Genera un botón (link con la clase *button*) con el nombre identificado por +name+. +options+
    # y +html_options+ se comportan igual que +link_to+. El efecto de transición se puede indicar
    # con +:effect+ en +html_options+.
    #
    # Ejemplo:
    #
    #   mobile_button_to("About", "#about", :class => "leftButton", :effect => "flip")
    #
    # Genera:
    #
    #   <a href="#about" class="button leftButton flip">About</a>
    def mobile_button_to(name, options, html_options={})    
      html_options[:class] = ["button",
                              html_options.delete(:class), 
                              html_options.delete(:effect)].compact.join(" ")
      link_to(name, options, html_options)
    end
    
    # Genera un item de una lista (li a). +item+ es un Hash que contiene, al menos los keys +name+ 
    # y +:url+. Adicionalmente se puede especificar +:target+, +:effect+, +:count+, +:icon+.
    #
    #   mobile_list_item :name => "Test Item 1", :url => "#test_item_1"
    #   mobile_list_item :name => "Test Item 1", :url => "#test_item_1", :icon => "arrow"
    #   mobile_list_item :name => "Test Item 2", :url => "#test_item_2", :icon => "forward", :count => 4
    #
    # Genera:
    #
    #   <li><a href="#test_item">Test Item</a></li>
    #   <li class="arrow"><a href="#test_item_1">Test Item 1</a></li>
    #   <li class="forward"><a href="#test_item_2">Test Item 2</a><small class="counter">4</small></li>
    def mobile_list_item(item, options = {})
      raise "Hash with keys :name and :url needed" unless item.has_key?(:name) && item.has_key?(:url)
      effect = options.delete(:effect) || nil
      icon_class = item.delete(:icon) || nil
      options[:class] = effect if effect 
      options[:target] = item[:target] if item.has_key?(:target)
      counter = item.has_key?(:count) ? item_count(item.delete(:count)) : ""
      
      content_tag(:li, link_to(item[:name], item[:url], options) + counter, :class => icon_class)
    end
    
    # Genera una lista (ul), con la clase +rounded+ por defecto, los elementos de la lista son especificados
    # por +items+, los cuales cumplen con lo mismo especificado para el atributo +item+ de +mobile_list_item+.
    # +options+ permite especificar opciones a los links generados en +mobile_list_item+, excepto por la oipción
    # :class, la cual permite indicar el tipo de listado ("rounded", "edgetoedge", "metal").
    #
    #
    # Ejemplo:
    #
    #   items = [
    #     {:name => "Test Item", :url => "#test_item"},
    #     {:name => "Test Item 2", :url => "#test_item2", :target => "_self"}]
    #
    #   mobile_list(items, :effect => "flip")
    #
    # Genera:
    #
    #   <ul class="rounded">
    #     <li><a href="#test_item" class="flip">Test Item</a></li>
    #     <li><a href="#test_item2" class="flip" target="_self">Test Item 2</a></li>
    #   </ul>
    def mobile_list(items, options = {})
      list_style = options.delete(:class) || "rounded"
      items.map! {|i| mobile_list_item(i, options) }
      content_tag(:ul, items.join, :class => list_style)
    end
    
    private
    
    def build_toolbar(title, options = {}, &proc)
      proc = block_given? ? capture(&proc) : ""
      back = options.delete(:back_button)
      html = back ? mobile_back_button(back) : ""
      
      content_tag :div, 
        content_tag(:h1, title) + proc + html,
        :class => 'toolbar'
    end
    
    def build_page(id, options = {}, prebody_html = "", &proc)
      proc = block_given? ? capture(&proc) : ""
      options.merge!(:id => "#{id}")
      content_tag(:div, prebody_html + proc, options)
    end
    
    def item_count(value)
      content_tag :small, value, :class => "counter"      
    end
    
  end
end
