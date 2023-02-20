class OrderDetail < ApplicationRecord

  #アソシエーション
  belongs_to :order
  belongs_to :item


  # バリデーション
  validates :item_id, :order_id, :amount, :price, presence: true
  validates :price, :amount, numericality: { only_integer: true }

  # enum設定 # enumの記述方式
  enum making_status: { make_no: 0, make_wait: 1, making: 2, make_done: 3 }

end
