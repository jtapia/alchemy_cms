module Alchemy
  module Translations
    class TranslationPusher
      def push_all_english_content_to_localeapp
        Alchemy::Page.where(language_code: 'en').each do |page|
          contents = page.elements.map(&:contents).flatten
          contents.each do |content|
            Rails.logger.info "processing #{content.name} #{content.essence.class}"
            next unless [Alchemy::EssenceText,Alchemy::EssenceRichtext,Alchemy::EssenceHtml].include? content.essence.class
            Rails.logger.info "adding #{Alchemy::Translations::TRANSLATION_PREFIX}#{content.name} #{content.essence.body} to localeapp queue"
            Localeapp.missing_translations.add('en', "#{Alchemy::Translations::TRANSLATION_PREFIX}#{content.name}", content.essence.body)
          end
          Localeapp.sender.post_missing_translations
        end
      end
    end
  end
end
