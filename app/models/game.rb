class Game < ApplicationRecord
  attr_accessor :dice

  def initialize(dice_num)
    @dice_num = dice_num
    @dice = Array.new(@dice_num) { rand(1..6) }
  end

  def roll_dice
    @dice = Array.new(@dice_num) { rand(1..6) }
  end
end
