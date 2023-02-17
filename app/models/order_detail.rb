class OrderDetail < ApplicationRecord

  #アソシエーション
  belongs_to :order
  belongs_to :item

  # enum設定 # enumの記述方式
  enum making_status: {"製作不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}

  # バリデーション
  validates :items_id, :order_id, :amount,
            :price, presence: true
  validates :price, :amount, numericality: { only_integer: true }

end
