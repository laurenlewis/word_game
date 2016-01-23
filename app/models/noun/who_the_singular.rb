module Noun
  module WhoTheSingular
    @words = [
      'the cat',
      'the dog',
      'the zebra',
      'the buzzard',
      'the man',
      'the woman',
      'the doctor',
      'the beekeeper',
      'the leprechaun',
      'the family',
      'the fox',
      'the rabbit',
      'the giraffe',
      'the zookeeper',
      'the unicorn',
      'the dragon',
      'the gorilla',
      'the weaver',
      'the snake',
      'the witch',
    ]

    class << self
      attr_reader :words

      def verb
        'who is'
      end
    end
  end
end
