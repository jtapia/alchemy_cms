module Alchemy
  module Translations
    class EssenceBodyUpdater

      def update_bodies(translations)
        binding.pry
        Rails.logger.info "Updating essences with #{translations}"

        locales = translations.keys

        locales.each do |locale|
          all_translated_content.each do |content|
            begin
              next unless locale == content.essence.element.page.language.language_code
              # do we have a translation for this alchemy essence?
              if translation = translations[locale][TRANSLATION_PREFIX][content.name]
                Rails.logger.info "Updating essence: #{content.name}"
                content.essence.update_attributes(body: translation)
              else
                Rails.logger.info "Skipping essence: #{content.name} b/c no new translation"
                next
              end

            rescue => e
              Rails.logger.error "Error in Alchemy update_bodies for content: #{content}: #{e}"
            end
          end
        end
      end

      private
      def all_translated_content
          t = Alchemy::Content.arel_table

          Alchemy::Content.where(t[:essence_type].eq('Alchemy::EssenceText').or(
                                t[:essence_type].eq('Alchemy::EssenceRichtext')).or(
                                t[:essence_type].eq('Alchemy::EssenceHtml')))
      end
    end
  end

      # revisit this for performance reasons
=begin
          all_translated_content_for_locale(locale).each do |content|
            begin
              content.first.essence.element.page.language.language_code
            rescue => e
              Rails.logger.error "Error in Alchemy update_bodies for content: #{content}: #{e}"
            end
          end

      def not_used_all_translated_content_for_locale(locale)
        # for performance reasons, drill down to the locale-specific essences from the Page vs. Essence.where...
        Alchemy::Page.where(language_code: locale).each do |
          t = Alchemy::Content.arel_table

          Alchemy::Content.first.essence.element.page.language.language_code

          Alchemy::Content.where(t[:essence_type].eq('Alchemy::EssenceText').or(
                                t[:essence_type].eq('Alchemy::EssenceRichtext')).or(
                                t[:essence_type].eq('Alchemy::EssenceHtml')))
        end
  =end
end
