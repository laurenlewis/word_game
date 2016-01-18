module Noun
  module WhoThePlural
    @words = [
      'the cats',
      'the dogs',
      'the zebras',
      'the buzzards',
      'the men',
      'the women',
      'the doctors',
      'the beekeepers',
      'the leprechauns',
      'the families',
      'the foxes',
      'the rabbits',
      'the giraffes',
      'the zookeepers',
      'the unicorns',
      'the dragons',
      'the gorillas',
      'the weavers',
      'the snakes',
      'the witches',
    ]

    private

    class << self
      attr_reader :words

      def verb
        'who are'
      end
    end
  end
end
