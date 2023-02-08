class Item < ApplicationRecord


  # ActiveStrage/画像を持たせる
  has_one_attached :image

end
