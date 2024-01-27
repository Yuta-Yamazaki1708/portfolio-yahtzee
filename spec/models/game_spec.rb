require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "バリデーションテスト" do
    let(:game) { build(:game) }

    it "Game.newが有効であること" do
      expect(game).to be_valid
    end

    it "oneの取り得る値が有効であること" do
      [0, 1, 2, 3, 4, 5].all? do |num|
        game.one = num
        expect(game).to be_valid
      end
    end

    it "twoの取り得る値が有効であること" do
      [0, 2, 4, 6, 8, 10].all? do |num|
        game.two = num
        expect(game).to be_valid
      end
    end

    it "threeの取り得る値が有効であること" do
      [0, 3, 6, 9, 12, 15].all? do |num|
        game.three = num
        expect(game).to be_valid
      end
    end

    it "fourの取り得る値が有効であること" do
      [0, 4, 8, 12, 16, 20].all? do |num|
        game.four = num
        expect(game).to be_valid
      end
    end

    it "fiveの取り得る値が有効であること" do
      [0, 5, 10, 15, 20, 25].all? do |num|
        game.five = num
        expect(game).to be_valid
      end
    end

    it "sixの取り得る値が有効であること" do
      [0, 6, 12, 18, 24, 30].all? do |num|
        game.six = num
        expect(game).to be_valid
      end
    end

    it "bonusの取り得る値が有効であること" do
      [0, 35].all? do |num|
        game.bonus = num
        expect(game).to be_valid
      end
    end

    it "choiceの取り得る値が有効であること" do
      [0, *5..30].all? do |num|
        game.choice = num
        expect(game).to be_valid
      end
    end

    it "four_dicesの取り得る値が有効であること" do
      [0, *5..30].all? do |num|
        game.four_dices = num
        expect(game).to be_valid
      end
    end

    it "full_houseの取り得る値が有効であること" do
      [0, *5..30].all? do |num|
        game.full_house = num
        expect(game).to be_valid
      end
    end

    it "small_straightの取り得る値が有効であること" do
      [0, 15].all? do |num|
        game.small_straight = num
        expect(game).to be_valid
      end
    end

    it "big_straightの取り得る値が有効であること" do
      [0, 30].all? do |num|
        game.big_straight = num
        expect(game).to be_valid
      end
    end

    it "yachtの取り得る値が有効であること" do
      [0, 50].all? do |num|
        game.yacht = num
        expect(game).to be_valid
      end
    end
  end

  describe "#display_result" do
    let(:game) { build(:game) }

    it "結果を表示できること" do
      expect(game.display_results).to include({
        "one" => nil,
        "two" => nil,
        "three" => nil,
        "four" => nil,
        "five" => nil,
        "six" => nil,
        "bonus" => nil,
        "choice" => nil,
        "four_dices" => nil,
        "full_house" => nil,
        "small_straight" => nil,
        "big_straight" => nil,
        "yacht" => nil,
        "sum" => nil,
      })
    end
  end

  describe ".roll_dices" do
    it "要素数５、１から６のランダムな値の配列が返ってくること" do
      dices = Game.roll_dices(5)

      expect(dices).to be_an(Array)
      expect(dices.size).to eq 5
      dices.all? do |dice|
        expect(dice).to be_between(1, 6)
      end
    end
  end

  describe ".move" do
    it "指定したindexの要素の移動ができること" do
      from_array = [0, 1, 2, 3, 4]
      to_array = []
      Game.move(from_array, to_array, 0)

      expect(from_array).to match_array([1, 2, 3, 4])
      expect(to_array).to match_array([0])

      Game.move(from_array, to_array, 3)
      expect(from_array).to match_array([1, 2, 3])
      expect(to_array).to match_array([0, 4])
    end
  end

  describe ".calculate_scores" do
    context "配列に0が含まれていた場合" do
      it "結果にnilを代入すること" do
        dices = Array.new(5) { 0 }
        calculated_scores = Game.calculate_scores(dices)

        calculated_scores.values.all? do |calculated_score|
          expect(calculated_score).to eq nil
        end
      end
    end

    context "1が0個の場合" do
      dices = [2, 2, 3, 3, 4]
      calculated_scores = Game.calculate_scores(dices)

      it "oneの結果が0であること" do
        expect(calculated_scores["one"]).to eq 0
      end
    end

    context "1が5個の場合" do
      dices = [1, 1, 1, 1, 1]
      calculated_scores = Game.calculate_scores(dices)

      it "oneの結果が5であること" do
        expect(calculated_scores["one"]).to eq 5
      end

      it "four_dicesに結果が配列の合計値であること" do
        expect(calculated_scores["four_dices"]).to eq 5
      end

      it "yachtの結果が50であること" do
        expect(calculated_scores["yacht"]).to eq 50
      end
    end

    context "1が4個、2が1個の場合" do
      dices = [1, 1, 1, 1, 2]
      calculated_scores = Game.calculate_scores(dices)

      it "oneの結果が4であること" do
        expect(calculated_scores["one"]).to eq 4
      end

      it "twoの結果が2であること" do
        expect(calculated_scores["two"]).to eq 2
      end

      it "four_dicesに結果が配列の合計値であること" do
        expect(calculated_scores["four_dices"]).to eq 6
      end
    end

    context "1が3個、2が2個の場合" do
      dices = [1, 1, 1, 2, 2]
      calculated_scores = Game.calculate_scores(dices)

      it "oneの結果が3であること" do
        expect(calculated_scores["one"]).to eq 3
      end

      it "twoの結果が4であること" do
        expect(calculated_scores["two"]).to eq 4
      end

      it "full_houseの結果が配列の合計値であること" do
        expect(calculated_scores["full_house"]).to eq 7
      end
    end

    context "配列が1,2,3,4,5を含む場合" do
      dices = [3, 2, 5, 4, 1]
      calculated_scores = Game.calculate_scores(dices)

      it "small_straightの結果が15であること" do
        expect(calculated_scores["small_straight"]).to eq 15
      end

      it "big_straightの結果が30であること" do
        expect(calculated_scores["big_straight"]).to eq 30
      end
    end

    context "配列が2,3,4,5,6を含む場合" do
      dices = [3, 2, 5, 4, 6]
      calculated_scores = Game.calculate_scores(dices)

      it "small_straightの結果が15であること" do
        expect(calculated_scores["small_straight"]).to eq 15
      end

      it "big_straightの結果が30であること" do
        expect(calculated_scores["big_straight"]).to eq 30
      end
    end
  end
end
