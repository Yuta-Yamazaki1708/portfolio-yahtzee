class Game < ApplicationRecord
  belongs_to :user, optional: true
  has_one :post, dependent: :destroy

  validates :one, inclusion: { in: [nil, 0, 1, 2, 3, 4, 5] }
  validates :two, inclusion: { in: [nil, 0, 2, 4, 6, 8, 10] }
  validates :three, inclusion: { in: [nil, 0, 3, 6, 9, 12, 15] }
  validates :four, inclusion: { in: [nil, 0, 4, 8, 12, 16, 20] }
  validates :five, inclusion: { in: [nil, 0, 5, 10, 15, 20, 25] }
  validates :six, inclusion: { in: [nil, 0, 6, 12, 18, 24, 30] }
  validates :bonus, inclusion: { in: [nil, 0, 35] }
  validates :choice, inclusion: { in: [nil, 0, *5..30] }
  validates :four_dices, inclusion: { in: [nil, 0, *5..30] }
  validates :full_house, inclusion: { in: [nil, 0, *5..30] }
  validates :small_straight, inclusion: { in: [nil, 0, 15] }
  validates :big_straight, inclusion: { in: [nil, 0, 30] }
  validates :yacht, inclusion: { in: [nil, 0, 50] }
  validates :sum, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 335 }

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

    caluculated_scores["small_straight"] = check_s_straight(array) == true ? 15 : 0

    caluculated_scores["big_straight"] = check_b_straight(array) == true ? 30 : 0

    caluculated_scores["yacht"] = array.uniq.size == 1 ? 50 : 0

    caluculated_scores
  end

  def self.check_s_straight(array)
    sorted_array = array.uniq.sort
    sorted_array.each_cons(4) do |subarray|
      if subarray.each_cons(2).all? { |a, b| b == a + 1 }
        return true
      end
    end
  end

  def self.check_b_straight(array)
    sorted_array = array.uniq.sort
    sorted_array.each_cons(5) do |subarray|
      if subarray.each_cons(2).all? { |a, b| b == a + 1 }
        return true
      end
    end
  end
end
