module Alchemy
  module Translations
    # we want to prepend all translated data bound four our translation engine
    # with this prefix for orgainizational/namespace reasons
    TRANSLATION_PREFIX = ENV['TRANSLATION_PREFIX']
    #TRANSLATION_PREFIX = 'do_not_translate'
  end
end
