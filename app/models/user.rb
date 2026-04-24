class User < ApplicationRecord

  has_many :products
  has_many :purchaseds

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ # 漢字・ひらがな・カタカナ
  with_options presence: true do
    validates :nickname
    validates :birth_date

    # 名前漢字入力
    validates :last_name, format: { with: VALID_NAME_REGEX }
    validates :first_name, format: { with: VALID_NAME_REGEX }

    # 名前カナ（全角）のバリデーション
    validates :last_name_kana, presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力してください' }
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字混合で入力してください'
end
