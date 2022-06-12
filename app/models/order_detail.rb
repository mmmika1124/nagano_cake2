class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { not_started: 0, waiting: 1, making: 2, completed: 3 }

  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true

end
