module Webportals
  class Engine < ::Rails::Engine
    isolate_namespace Webportals

    middleware.use "Rack::JSONP"

    config.assets.precompile += %w( 
      markers-soft.png
      markers-shadow.png
      markers-soft@2x.png
      markers-shadow@2x.png
      leaflet.js
      leaflet_google_layer.js
      mustache.js
      leaflet
    )

    config.after_initialize do
      Webportals.configure_search_engine
    end
  end
end
