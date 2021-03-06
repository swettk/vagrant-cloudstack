require "log4r"

module VagrantPlugins
  module Cloudstack
    module Action
      # This terminates the running instance.
      class TerminateInstance
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_cloudstack::action::terminate_instance")
        end

        def call(env)
          server = env[:cloudstack_compute].servers.get(env[:machine].id)

          # Destroy the server and remove the tracking ID
          env[:ui].info(I18n.t("vagrant_cloudstack.terminating"))
          server.destroy
          env[:machine].id = nil

          @app.call(env)
        end
      end
    end
  end
end
