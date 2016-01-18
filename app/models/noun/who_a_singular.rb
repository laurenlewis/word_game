module Noun
  module WhoASingular
    @words = [
      'a cat',
      'a dog',
      'a zebra',
      'a buzzard',
      'a man',
      'a woman',
      'a doctor',
      'a beekeeper',
      'a leprechaun',
      'a family',
      'a fox',
      'a rabbit',
      'a giraffe',
      'a zookeeper',
      'a unicorn',
      'a dragon',
      'a gorilla',
      'a weaver',
      'a snake',
      'a witch',
    ]

    class << self
      attr_reader :words

      def verb
        'who is'
      end
    end
  end
end
