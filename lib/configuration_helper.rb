module Jqtouch
  
  module ConfigurationHelper
    
    # Permite generar el javascript para agregar las opciones de configuración de jqtouch.
    # +options+ es un Hash que es convertido en json, y que especifican las opciones que se pasan
    # como argumento a $(document).jQTouch.
    #
    # Ejemplo:
    #
    #   <%= jqtouch_init :status_bar => 'black-translucent' %>
    #
    # Genera el siguiente código:
    #
    #   <script charset="utf-8" type="text/javascript">
    #   //<![CDATA[
    #   $(document).jQTouch({"statusBar": "black-translucent"});
    #   //]]>
    #   </script>
    def jqtouch_init(options={})
      javascript_tag "$(document).jQTouch(#{options.camelize_keys!(:lower).to_json});", :charset => "utf-8"
    end
  end
  
end
