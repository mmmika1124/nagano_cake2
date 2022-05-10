class Item < ApplicationRecord
  attachment :image
  belongs_to :genre

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

end
