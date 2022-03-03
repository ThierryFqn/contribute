class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :asso

  has_many :messages
end
