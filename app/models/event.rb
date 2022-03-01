class Event < ApplicationRecord
  has_many_attached :photos
  belongs_to :asso
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  EVENT_CAUSES = ["la jeunesse", "la protection de l'environnement", "la transmission des savoirs", "l'égalité", "la prévention et la santé", "la pauvreté et l'isolement"]

  validates :address, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :cause, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_volunteers, numericality: { only_integer: true }

  before_save :attach_photo

  def attach_photo
    return if photos.attached?
    self.photos.attach(io: File.open(File.join(Rails.root,'app/assets/images/default-image.jpeg')), filename: 'default image')
  end
end
