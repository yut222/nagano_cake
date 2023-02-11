class CartItem < ApplicationRecord

  #アソシエーション
  belongs_to :customers
  belongs_to :items

  # バリデーション
  validates :amount, presence: true

end
