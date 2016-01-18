module Sentence
  def self.build
    [
      Sentence::NounAnimate,
      Sentence::NounInanimate,
      Sentence::NounVerbNoun,
      Sentence::PronounVerbNoun,
    ].sample.generate
  end
end
