module Alchemy
  module Admin
    class AllTranslationsController < Alchemy::Admin::BaseController

      authorize_resource class: :alchemy_admin_all_translations

      def index
        ::Localeapp::CLI::Pull.new.execute
      end

    end
  end
end
