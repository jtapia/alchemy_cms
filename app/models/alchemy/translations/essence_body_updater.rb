module Alchemy
  module Translations
    class EssenceBodyUpdater

      def update_bodies(translations)
        Rails.logger.error "Updating essences with #{translations}"

        locales = translations.keys

        locales.each do |locale|
          unless translations[locale]
            Rails.logger.error "Skipping locale: #{locale} b/c no changes"
            next
          end
          all_translated_content.each do |content|
            begin
              next unless locale == content.essence.element.page.language.language_code
              if content.name == "megacrate_winner_prize_3"

    # Updating essences with {"de"=>{"do_not_translate"=>{"megacrate_winner_prize_3"=>"<p>waz it fake German10</p>"}}}

                # checking for key: {"do_not_translate"=>{"megacrate_winner_prize_3"=>"<p>waz it fake German9</p>"}, "specialty_crates"=>{"fallout-4-crate"=>{"checkouts"=>{"button_copy"=>nil, "disclaimer"=>nil, "vat"=>nil}, "collection"=>{"email_template"=>nil, "list"=>nil}}}}[do_not_translate.][megacrate_winner_prize_3]
# and we have: {"do_not_translate"=>{"megacrate_winner_prize_3"=>"<p>waz it fake German9</p>"}, "specialty_crates"=>{"fallout-4-crate"=>{"checkouts"=>{"button_copy"=>nil, "disclaimer"=>nil, "vat"=>nil}, "collection"=>{"email_template"=>nil, "list"=>nil}}}} for the preamble

                begin
                  translation = translations[locale][TRANSLATION_PREFIX][content.name] rescue nil
                  Rails.logger.error "got translation: #{translation}"
                rescue => e2
                  Rails.logger.error "WTF??? #{e2}"
                end
              end
              # do we have a translation for this alchemy essence?
              translation = translations[locale][TRANSLATION_PREFIX][content.name] rescue nil
              if translation
                Rails.logger.error "Updating essence: #{content.name}"  if content.name == "megacrate_winner_prize_3"
                content.essence.update_attributes(body: translation)
              else
                Rails.logger.error "Skipping essence: #{content.name} b/c no new translation" if content.name == "megacrate_winner_prize_3"
                next
              end

            rescue => e
              Rails.logger.error "Error in Alchemy update_bodies for content: #{content.name}: #{e}" rescue nil
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
