class Asso < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
