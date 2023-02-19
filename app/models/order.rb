class Order < ApplicationRecord

  # アソシエーション
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  # バリデーション
  validates :address, :name, :shipping_cost,
            :total_payment, :payment_method,
             presence: true
  validates :postal_code, length: {is: 7}
  validates :shipping_cost, :total_payment, numericality: { only_integer: true }

  # enum設定
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait: 0, check: 1, make: 2, delivery: 3, delivery_done: 4 }

  # devise enum? 記述を簡単に  # お届け先
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end