module Adjective
  module Inanimate
    @words = [
      'old',
      'broken',
      'shattered',
      'crunchy',
      'smooshed',
      'dry',
      'green',
      'red',
      'blue',
      'yellow',
      'purple',
      'pink',
      'orange',
      'warm',
      'stiff',
      'sticky',
      'hot',
      'cold',
      'freezing',
    ]

    class << self
      attr_reader :words
    end
  end
end
