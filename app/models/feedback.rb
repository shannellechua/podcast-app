class Feedback < ApplicationRecord
  # Change the belongs_to relationship to just validate the presence of podcast_id
  validates :podcast_id, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end