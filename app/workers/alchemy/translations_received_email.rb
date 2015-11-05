module Alchemy
  class TranslationReceivedEmail
    include Sidekiq::Worker
    sidekiq_options queue: :low

    def perform(translations)
      Alchemy::TranslationMailer.translation_received(ENV['TRANSLATION_RECEIVED_EMAILS'] || 'jeff@lootcrate.com', JSON.parse(translations)).deliver_now
    end
  end
end
