class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  validates :status, presence: true

  enum status: { pending: 0, accepted: 1, denied: 2, confirmed: 3, cancelled: 4 }
end
