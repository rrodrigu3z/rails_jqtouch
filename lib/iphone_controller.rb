module Jqtouch
  # Incluye macros y filtros varios para facilitar el trabajo con controladores que requieren procesar
  # requests desde un Iphone o un Ipod Touch (Navegadores Mobile Safari).
  #
  # El código original es tomado de rails-iui (git://github.com/noelrappin/rails-iui.git) by
  # Noel Rappin.
  #  
  # Ejemplos de uso:
  #  
  # +acts_as_iphone_controller+ está disponible para incluirse en un controlador en específico o en el
  # ApplicationController. Automåticamente se asigna el filtro +set_iphone_format+ que se encarga de
  # asignar a +request.format+ el formato +:iphone+.
  #  
  #   class TareasController < ApplicationController
  #     acts_as_iphone_controller
  #     ...
  #   end
  #    
  # Si se incluye +acts_as_iphone_controller(true)+, todos los requests son tratados como provenientes
  # de una navegador Mobile Safari, por lo que +request.format+ siempre será +:iphone+. Útil durante
  # el desarrollo, para pruebas y depuración.
  module IphoneController
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
    
      def acts_as_iphone_controller(iphone_test_mode = false)
        @@iphone_test_mode = iphone_test_mode
        include IphoneController::InstanceMethods 
        iphone_test_mode ? before_filter(:force_iphone_format) : before_filter(:set_iphone_format)
        helper_method :is_iphone_request?
      end
      
      def iphone_test_mode?
        @@iphone_test_mode
      end
    end
    
    module InstanceMethods
      private
      
      # Fuerza que +request.format+ siempre sea +:iphone+
      def force_iphone_format
        request.format = :iphone
      end
      
      # Asigna +request.format+ a +:iphone+ dependiendo si el request provino de un navegador
      # Mobile Safari o de un subdominio tipo iphone.dominio.com.
      #
      # Para los casos en que, desde uno de estos dispositivos, se desee ver el website completo
      # original, asignar el valor +"desktop"+ a +cookies["browser"]+.
      def set_iphone_format
        if is_iphone_request? || is_iphone_format? || is_iphone_subdomain?
          request.format = cookies["browser"] == "desktop" ? :html : :iphone 
        end
      end
      
      # Devuelve +true+ si el +request.format+ asignado es +:iphone+
      def is_iphone_format?
        request.format.to_sym == :iphone
      end
      
      # Verifica que el User Agent sea el correspondiente a Mobile Safari, para lo cual devuelve +true+.
      def is_iphone_request?
        request.user_agent =~ /(Mobile\/.+Safari)/
      end
      
      # Verifica que el subdominio sea del tipo iphone.dominio.com.
      def is_iphone_subdomain?
        request.subdomains.first == "iphone"
      end
    end #InstanceMethods
  end #IphoneController
end #ActionController
