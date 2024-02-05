class Room < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :reservations
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :prefecture, presence: true
  enum prefecture: {
    hokkaido: "北海道（札幌）",
    tokyo: "東京都",
    osaka: "大阪府",
    kyoto: "京都府"
  }
end
