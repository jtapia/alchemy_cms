module Alchemy
  module Translations
    # we want to prepend all translated data bound for our translation engine
    # with this prefix for orgainizational/namespace reasons
    TRANSLATION_PREFIX  = if Rails.env.production? 
      'cms'
    else
      'do_not_translate'
    end
  end
end


