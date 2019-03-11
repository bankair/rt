require 'color'
require 'tuple'

class Light
  class Point
    attr_reader :position, :intensity

    def initialize(position, intensity)
      @position = position
      @intensity = intensity
    end
  end
end
