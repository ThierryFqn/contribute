class Event < ApplicationRecord
  has_many_attached :photos
  belongs_to :asso
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  validates :address, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :cause, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_volunteers, numericality: { only_integer: true }
end
