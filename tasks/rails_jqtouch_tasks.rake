include FileUtils

# Ruta donde se encuentran los fuentes de jqtouch y las plantillas de los layouts.
ASSETS_PATH = File.join(File.dirname(__FILE__), '../assets')
# Versión de jqtouch utilizada
JQT_VERSION = "1.0-beta-2-r109"

namespace :rails_jqtouch do
  
  desc "Muestra la versión de jqtouch utilizada"
  task :jqtouch_version do
    puts JQT_VERSION
  end
  
  desc 'Copia los js de jqtouch en public/javascripts'
  task :install_javascripts => :environment do
    cp_r "#{ASSETS_PATH}/javascripts/jqtouch", "#{RAILS_ROOT}/public/javascripts"
  end
  
  desc 'Copia las hojas de estilos, imágenes y temas en public/stylesheets'
  task :install_stylesheets => :environment do
    cp_r "#{ASSETS_PATH}/stylesheets/jqtouch", "#{RAILS_ROOT}/public/stylesheets"
  end
  
  desc 'Copia el layout application.iphone.erb a app/views/layouts'
  task :install_layouts => :environment do
    Dir.chdir("#{ASSETS_PATH}/layouts") do
      cp "application.iphone.erb", "#{RAILS_ROOT}/app/views/layouts"
    end
  end

  desc 'instala las hojas de estilos, javascripts, imágenes y layouts'
  task :install => [:install_javascripts, :install_layouts, :install_stylesheets]
  
  desc 'Elimina los javascripts instalados'    
  task :clean_javascripts => :environment do
    rm_r "#{RAILS_ROOT}/public/javascripts/jqtouch"
  end
  
  desc 'Elimina los layouts instalados'
  task :clean_layouts => :environment do
    rm "#{RAILS_ROOT}/app/views/layouts/application.iphone.erb"
  end
  
  desc 'Elimina las hojas de estilos y las imagenes asociadas'
  task :clean_stylesheets => :environment do
    rm_r "#{RAILS_ROOT}/public/stylesheets/jqtouch"
  end
  
  desc 'Limpia la instalación de jqtouch, removiendo los javascripts, hojas de estilos, imágenes y layouts'
  task :clean => [:clean_javascripts, :clean_layouts, :clean_stylesheets]
  
end