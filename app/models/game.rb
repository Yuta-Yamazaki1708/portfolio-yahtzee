class Game < ApplicationRecord
  def roll_dices(dice_num)
    dices = Array.new(dice_num) { rand(1..6) }
    dices
  end

  def move(from_array, to_array, index)
    tmp = from_array[index]
    from_array.delete_at(index)
    to_array.push(tmp)
  end
end
