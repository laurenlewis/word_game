module Noun
  module ThatASingular
    @words = [
      'an avocado',
      'a beehive',
      'a pumpkin',
      'a book',
      'an apple',
      'a banana',
      'a cupcake',
      'a sandwich',
      'a fur coat',
      'a shadow',
      'a bell',
      'a rock',
      'a pebble',
      'a tree',
      'a twig',
      'a knife',
      'a clock',
    ]

    class << self
      attr_reader :words

      def verb
        'that is'
      end
    end
  end
end
