module Adjective
  module Animate
    @words = [
      'sticky',
      'hungry',
      'tired',
      'happy',
      'popular',
      'stiff',
      'grumpy',
      'scared',
      'strong',
      'cute',
      'nice',
      'afraid',
      'lucky',
      'angry',
      'asleep',
      'green',
      'young',
      'warm',
      'sad',
      'sick',
      'brave',
      'calm',
      'smart',
      'drunk',
      'tricked',
      'rowdy',
      'hot',
      'testy',
      'confused',
      'fashionable',
      'old',
      'dry',
    ]

    class << self
      attr_reader :words
    end
  end
end
