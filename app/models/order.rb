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
  enum payment_method: {credit_card:0, transfer:1}
  enum order_status: {入金待ち:0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}

  # devise enum? 記述を簡単に  # お届け先
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end