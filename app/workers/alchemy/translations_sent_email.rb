module Alchemy
  class TranslationSentEmail
    include Sidekiq::Worker
    sidekiq_options queue: :low

    def perform(translations)
      Alchemy::TranslationMailer.translation_sent(ENV['TRANSLATION_SENT_EMAILS'] || 'jeff@lootcrate.com', JSON.parse(translations)).deliver_now
    end
  end
end
