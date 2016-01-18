# Sentence::NounAnimate.generate
# Second
module Sentence
  module NounAnimate
    @steps = [
      :select_noun,
      :select_adjective,
    ]

    def self.generate
      @steps.flat_map do |step|
        send(step)
      end.join(' ')
    end

    private

    def self.select_noun
      noun = [
        Noun::WhoASingular,
        Noun::WhoTheSingular,
        Noun::WhoPlural,
        Noun::WhoThePlural,
      ].sample

      [noun.words.sample, noun.verb]
    end

    def self.select_adjective
       Adjective::Animate.words.sample
    end
  end
end
