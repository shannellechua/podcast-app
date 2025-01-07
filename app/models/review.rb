class Review < ApplicationRecord
  belongs_to :user
  belongs_to :show
  
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, uniqueness: { scope: :show_id, message: "You can only review a show once" }
end