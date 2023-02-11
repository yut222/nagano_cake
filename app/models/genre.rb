class Genre < ApplicationRecord

  #アソシエーション
  has_many :items, dependent: :destroy

  # バリデーション
  validates :name, uniqueness: true, presence: true

end
