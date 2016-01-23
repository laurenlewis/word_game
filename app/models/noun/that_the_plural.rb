module Noun
  module ThatThePlural
    @words = [
      'the avocados',
      'the beehives',
      'the pumpkins',
      'the books',
      'the apples',
      'the bananas',
      'the cupcakes',
      'the sandwiches',
      'the fur coats',
      'the shadows',
      'the bells',
      'the rocks',
      'the pebbles',
      'the trees',
      'the twigs',
      'the knives',
      'the clocks',
    ]

    class << self
      attr_reader :words

      def verb
        'that are'
      end
    end
  end
end
