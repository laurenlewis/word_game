# First
# Sentence::PronounVerbNoun.generate
module Sentence
  module PronounVerbNoun
    @steps = [
      :select_gender,
      :select_verb,
      :select_noun,
    ]

    def self.generate
      @steps.map do |step|
        send(step)
      end.join(' ')
    end

    private

    def self.select_gender
      [
        'She who',
        'He who'
      ].sample
    end

    def self.select_verb
      Verb::AnimateTransitiveThirdSingular.words.sample
    end

    def self.select_noun
      [
        Noun::ThatASingular,
        Noun::ThatTheSingular,
        Noun::ThatPlural,
        Noun::ThatThePlural,
        Noun::WhoASingular,
        Noun::WhoTheSingular,
        Noun::WhoPlural,
        Noun::WhoThePlural,
        Noun::Abstract,
      ].sample.words.sample
    end
  end
end
