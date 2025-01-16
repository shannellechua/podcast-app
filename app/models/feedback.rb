class Feedback < ApplicationRecord
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  validates :podcast_id, presence: true
end