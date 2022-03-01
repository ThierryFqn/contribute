class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :participations, dependent: :destroy
  has_many :assos, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :day_birth, presence: true

  has_one_attached :photo
  before_save :attach_photo

  def attach_photo
    return if photo.attached?
    self.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/default-avatar.jpeg')), filename: 'avatar')
  end
end
