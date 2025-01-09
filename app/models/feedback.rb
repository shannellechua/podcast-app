class Feedback < ApplicationRecord
    belongs_to :podcast
    validates :podcast, :rating, presence: true, inclusion: { in: 1..5 }
  end