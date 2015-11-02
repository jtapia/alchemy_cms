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

          # :essence_name => { :locale => :id }
          all_translated_content.each_key do |essence_name|
            essence_id = all_translated_content[essence_name][locale]

            # do we have an essence for this name/locale?
            next unless essence_id

              # do we have a translation for this alchemy essence?
              translation = translations[locale][TRANSLATION_PREFIX][essence_name] rescue nil
              if translation
                # Rails.logger.error "Updating essence: #{content.name}" if content.name == "megacrate_winner_prize_3"
                essence = Alchemy::Essence.find(essence_id) rescue nil
                essence.update_attributes(body: translation) if essence
              end

            rescue => e
              Rails.logger.error "Error in Alchemy update_bodies for content: #{content.name}: #{e}" rescue nil
            end
          end
        end
      end

      private
      def all_translated_content
        if data = Alchemy.redis.get('all_translated_content')
          data
        else
          # :essence_name => { :locale => :essence_id }
          # let's populate our in-memory store
          t = Alchemy::Content.arel_table

          data = Hash.new
          Alchemy::Content.where(t[:essence_type].eq('Alchemy::EssenceText').or(
                                  t[:essence_type].eq('Alchemy::EssenceRichtext')).or(
                                  t[:essence_type].eq('Alchemy::EssenceHtml'))).each do |content|

            begin
              data[content.name] ||= {}
              data[content.name][content.essence.element.page.language.language_code] = content.essence.id
            rescue => e
              Rails.logger.error "Alchemy Error - malformed content: #{content.name}"
            end
          end

          Alchemy.redis.put('all_translated_content', data)
          data
        end
      end
    end
  end
end
