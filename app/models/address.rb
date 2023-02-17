class Address < ApplicationRecord

  # バリデーション
  validates :postal_code, :address, :name, presence: true

  # devise
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end
end
