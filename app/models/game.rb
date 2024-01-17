class Game < ApplicationRecord
  belongs_to :user, optional: true

  FACE_NUM = 6
  CATEGORIES = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "bonus",
    "choice",
    "four_dices",
    "full_house",
    "small_straight",
    "big_straight",
    "yacht",
    "sum",
  ].freeze

  # インスタンスメソッド.

  def display_results
    CATEGORIES.index_with { |category| public_send(category) }
  end

  # クラスメソッド.

  def self.roll_dices(dice_num)
    dices = Array.new(dice_num) { rand(1..FACE_NUM) }
    dices
  end

  def self.move(from_array, to_array, index)
    tmp = from_array[index]
    from_array.delete_at(index)
    to_array.push(tmp)
  end

  def self.calculate_scores(array)
    if array.include?(0)
      return CATEGORIES.index_with { |category| nil }
    end
    caluculated_scores = {}

    caluculated_scores["one"] ||= array.count { |num| num == 1 }

    caluculated_scores["two"] = array.count { |num| num == 2 } * 2

    caluculated_scores["three"] = array.count { |num| num == 3 } * 3

    caluculated_scores["four"] = array.count { |num| num == 4 } * 4

    caluculated_scores["five"] = array.count { |num| num == 5 } * 5

    caluculated_scores["six"] = array.count { |num| num == 6 } * 6

    caluculated_scores["choice"] = array.sum

    counts = array.uniq.map { |num| array.count(num) }
    caluculated_scores["four_dices"] = counts.include?(4) || counts.include?(5) ? array.sum : 0

    counts = array.uniq.map { |num| array.count(num) }
    caluculated_scores["full_house"] = counts.include?(3) && counts.include?(2) ? array.sum : 0

    sorted_dice = array.uniq.sort
    caluculated_scores["small_straight"] = check_s_straight(sorted_dice) == true ? 15 : 0

    sorted_dice = array.uniq.sort
    caluculated_scores["big_straight"] = check_b_straight(sorted_dice) == true ? 30 : 0

    caluculated_scores["yacht"] = array.uniq.size == 1 ? 50 : 0

    caluculated_scores
  end

  def self.check_s_straight(sorted_array)
    sorted_array.each_cons(4) do |subarray|
      if subarray.each_cons(2).all? { |a, b| b == a + 1 }
        return true
      end
    end
  end

  def self.check_b_straight(sorted_array)
    sorted_array.each_cons(5) do |subarray|
      if subarray.each_cons(2).all? { |a, b| b == a + 1 }
        return true
      end
    end
  end
end
