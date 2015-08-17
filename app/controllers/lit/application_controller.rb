module Lit
  class ApplicationController < ActionController::Base
    before_filter :authenticate
    before_filter :stop_hits_counter
    after_filter :restore_hits_counter

    private
      def authenticate
        if current_user && current_user.admin?
          return true
        else
          redirect_to "/", alert: "Brak uprawnien!"
        end
      end

      def stop_hits_counter
        Lit.init.cache.stop_hits_counter
      end

      def restore_hits_counter
        Lit.init.cache.restore_hits_counter
      end
  end
end
