class Asso < ApplicationRecord
  has_one_attached :photo
  belongs_to :user

  # has_many :memberships, dependent: :destroy
  # has_many :members, through: :memberships, source: :user

  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  # def member?(user)
  #   members.include?(user)
  # end
end
