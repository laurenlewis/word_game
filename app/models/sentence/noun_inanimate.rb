# Sentence::NounInanimate.generate
# Third
module Sentence
  module NounInanimate
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
        Noun::ThatASingular,
        Noun::ThatTheSingular,
        Noun::ThatPlural,
        Noun::ThatThePlural,
      ].sample

      [noun.words.sample, noun.verb]
    end

    def self.select_adjective
       Adjective::Inanimate.words.sample
    end
  end
end
