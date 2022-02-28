class Event < ApplicationRecord
  has_many_attached :photos
  belongs_to :asso
end
