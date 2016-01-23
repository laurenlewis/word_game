module Noun
  module ThatTheSingular
    @words = [
      'the avocado',
      'the beehive',
      'the pumpkin',
      'the book',
      'the apple',
      'the banana',
      'the cupcake',
      'the sandwich',
      'the fur coat',
      'the shadow',
      'the bell',
      'the rock',
      'the pebble',
      'the tree',
      'the twig',
      'the knife',
      'the clock',
    ]

    class << self
      attr_reader :words

      def verb
        'that is'
      end
    end
  end
end
