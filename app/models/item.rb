class Item < ApplicationRecord

  #アソシエーション
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  # has_many :orders, through: :order_details

  # ActiveStrage/画像を持たせる
  has_one_attached :image

  # バリデーション
  validates :genre_id, :name, :price, presence: true
  validates :introduction, length: {maximum: 200}, presence: true
  validates :price, numericality: { only_integer: true }, presence: true


  # 検索機能（部分検索）
  def self.search(word)
    Item.where("name LIKE?", "%#{word}%")
  end

end
