module Alchemy
  class TranslationMailer < ActionMailer::Base

    def translation_sent(to, translations)
      @translations = translations

      mail(
        from: 'translation-sent@lootcrate.com',
        from_name: 'translation-sent@lootcrate.com',
        to: to.split(','),
        subject: 'Translations sent to localeapp.com'
      )
    end


    def translation_received(to, translations)
      @translations = translations

      mail(
        from: 'translation-received@lootcrate.com',
        from_name: 'translation-received@lootcrate.com',
        to: to.split(','),
        subject: 'Translations received from localeapp.com'
      )
    end

  end
end
