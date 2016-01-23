# Sentence::NounVerbNoun.generate
# Fourth
module Sentence
  module NounVerbNoun
    @steps = [
      :select_conditional,
      :select_first_noun,
      :select_verb,
      :select_second_noun
    ]

    def self.generate
      @steps.map do |step|
        send(step)
      end.join(' ')
    end

    private

    def self.select_conditional
      [
        'When',
        'If',
        'After',
        'Unless',
      ].sample
    end

    def self.select_first_noun
      [
        Noun::WhoASingular,
        Noun::WhoTheSingular,
        Noun::WhoPlural,
        Noun::WhoThePlural,
      ].sample.words.sample
    end

    def self.select_verb
      Verb::AnimateTransitiveThirdSingular.words.sample
    end

    def self.select_second_noun
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
