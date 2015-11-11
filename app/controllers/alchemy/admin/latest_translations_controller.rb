module Alchemy
  module Admin
    class LatestTranslationsController < Alchemy::Admin::BaseController
      authorize_resource class: :alchemy_admin_latest_translations

      def index
        poller = ::Localeapp.poller
        poller.updated_at = 1.week.ago.to_i
        poller.poll!
      end

    end
  end
end
