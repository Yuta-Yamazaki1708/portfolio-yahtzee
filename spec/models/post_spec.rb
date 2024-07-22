require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "バリデーションテスト" do
    let(:user) { create(:user) }
    let(:game) { create(:game) }
    let(:post) { build(:post, user_id: user.id, game_id: game.id) }
    let(:post_long_comment) { build(:post, comment: 123456789012345678901, user_id: user.id, game_id: game.id) }

    it "Post.newが有効であること" do
      expect(post).to be_valid
    end

    it "commentが20文字以上の場合無効であること" do
      post_long_comment.valid?
      expect(post_long_comment.errors[:comment]).to include "は20文字以内で入力してください"
    end
  end
end
