class Address < ApplicationRecord

  # アソシエーション
  belongs_to :customer

  # バリデーション
  validates :postal_code, :address, :name, presence: true

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end
end
