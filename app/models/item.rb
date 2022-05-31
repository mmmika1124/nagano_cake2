class Item < ApplicationRecord
  attachment :image
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

end
