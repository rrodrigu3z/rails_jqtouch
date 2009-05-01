module Jqtouch
  
  module HashExtensions
    # Destructivamente cameliza todos los keys.
    # Por defecto, cconvierte los keys de la forma UpperCamelCase. Si el argumento +first_letter+ es
    # asigando a :lower, los keys generados son de la forma lowerCamelCase.  
    def camelize_keys!(first_letter = :upper)
      keys.each {|k| self[k.to_s.camelize(first_letter)] = delete(k) }
      self
    end
  end
end

Hash.send(:include, Jqtouch::HashExtensions)
