require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションテスト" do
    let(:user) { create(:user) }
    let(:name_nil) { build(:user, username: nil) }
    let(:email_nil) { build(:user, email: nil) }
    let(:same_email) { build(:user, email: user.email) }
    let(:password_nil) { build(:user, password: nil) }
    let(:short_password) { build(:user, password: "short") }
    let(:different_password_comfirmation) { build(:user, password: user.password, password_confirmation: "different") }
    let(:user_jpg_icon) { build(:user) }
    let(:user_svg_icon) { build(:user) }

    before do
      user_jpg_icon.icon.attach(fixture_file_upload('icon.jpg'))
      user_svg_icon.icon.attach(fixture_file_upload('icon.svg'))
    end

    it "usernameとemailとpassword、password_confirmationがある場合有効であること" do
      expect(user).to be_valid
    end

    it "usernameがない場合無効であること" do
      name_nil.valid?
      expect(name_nil.errors[:username]).to include "は必須です。"
    end

    it "emailがない場合無効であること" do
      email_nil.valid?
      expect(email_nil.errors[:email]).to include "は必須です。"
    end

    it "emailの値が唯一でない場合無効であること" do
      same_email.valid?
      expect(same_email.errors[:email]).to include "は登録済みです。"
    end

    it "passwordがない場合無効であること" do
      password_nil.valid?
      expect(password_nil.errors[:password]).to include "は必須です。"
    end

    it "passwordか6文字未満の場合無効であること" do
      short_password.valid?
      expect(short_password.errors[:password]).to include "は最低６文字です。"
    end

    it "password_comfirmationがpasswordと一致していない場合無効であること" do
      different_password_comfirmation.valid?
      expect(different_password_comfirmation.errors[:password_confirmation]).to include "が一致しません。"
    end

    context "iconにjpgファイルがattachされている場合" do
      it "icon_file_validationが有効であること" do
        expect(user_jpg_icon).to be_valid
      end
    end

    context "iconにsvgファイルがattachされている場合" do
      it "icon_file_validationが無効であること" do
        user_svg_icon.valid?
        expect(user_svg_icon.errors[:icon]).to include "はjpg,jpeg,png形式でアップロードしてください。"
      end
    end
  end

  describe "クラスメソッドテスト" do
    it "guestメソッドが有効であること" do
      guest_user = User.guest
      expect(guest_user).to be_valid
    end
  end
end
