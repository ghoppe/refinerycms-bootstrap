module Refinery
  module Bootstrap
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Bootstrap

      engine_name :refinery_bootstrap


      config.after_initialize do
        Refinery.register_extension(Refinery::Bootstrap)
      end
    end
  end
end
