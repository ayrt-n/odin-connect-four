# frozen_string_literal: true

# Class representation of a player in connect 4
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end
