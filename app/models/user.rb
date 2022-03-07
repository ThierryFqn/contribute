class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chatrooms, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :assos, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :days_preferences, presence: true
  # validates :causes_preferences, presence: true
  # validates :day_birth, presence: true

  has_one_attached :photo
  before_save :attach_photo

  def attach_photo
    return if photo.attached?
    self.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/default-avatar.jpg')), filename: 'avatar')
  end

  def participation_rate
    if participations.select(&:confirmed?).any?
      accepted_participations = participations.accepted.count
      confirmed_participations = participations.confirmed.count
      (confirmed_participations.fdiv(accepted_participations) * 100).round
    else
      false
    end
  end

  def counter_hours
    sum = 0
    participations.select(&:confirmed?).each do |participation|
      sum += participation.event.hours_calcul
    end
    sum.round
  end

  def counter_missions
    participations.select(&:confirmed?).count
  end
end
