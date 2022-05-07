class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
end
