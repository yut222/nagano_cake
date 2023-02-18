class Address < ApplicationRecord

  # バリデーション
  validates :postal_code, :address, :name, presence: true


end
