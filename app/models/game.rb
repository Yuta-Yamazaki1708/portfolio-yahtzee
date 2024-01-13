class Game < ApplicationRecord
  def roll_dices(dice_num)
    dices = Array.new(dice_num) { rand(1..6) }
    dices
  end
end
