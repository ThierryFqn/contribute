class Asso < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
