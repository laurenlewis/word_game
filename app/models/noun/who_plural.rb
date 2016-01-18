module Noun
  module WhoPlural
    @words = [
      'cats',
      'dogs',
      'zebra',
      'buzzards',
      'men',
      'women',
      'doctors',
      'beekeepers',
      'leprechauns',
      'families',
      'foxes',
      'rabbits',
      'giraffes',
      'zookeepers',
      'unicorns',
      'dragons',
      'gorillas',
      'weavers',
      'snakes',
      'witches',
    ]

    class << self
      attr_reader :words

      def verb
        'who are'
      end
    end
  end
end
