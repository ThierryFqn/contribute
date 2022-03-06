class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many_attached :photos
  belongs_to :asso

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  EVENT_CAUSES = ["la jeunesse", "la protection de l'environnement", "la transmission des savoirs", "l'égalité", "la prévention et la santé", "la pauvreté et l'isolement"]

  validates :name, presence: true
  validates :description, presence: true
  validates :cause, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_volunteers, numericality: { only_integer: true }
  validates :address, presence: true

  before_save :attach_photo

  enum status: { coming: 0, done: 1 }

  def attach_photo
    return if photos.attached?

    self.photos.attach(io: File.open(File.join(Rails.root,'app/assets/images/default-image.jpg')), filename: 'default image')
  end

  def hours_calcul
    (end_date.to_time - start_date.to_time) / 1.hours
  end

  def pending_participants
    participations.select(&:pending?)
  end

  def accepted_participants
    participations.select(&:accepted?)
  end
end
