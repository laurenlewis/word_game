module Noun
  module ThatPlural
    @words = [
      'avocados',
      'beehives',
      'pumpkins',
      'books',
      'apples',
      'bananas',
      'cupcakes',
      'sandwiches',
      'fur coats',
      'shadows',
      'bells',
      'rocks',
      'pebbles',
      'trees',
      'twigs',
      'knives',
      'clocks',
    ]

    class << self
      attr_reader :words

      def verb
        'that are'
      end
    end
  end
end
