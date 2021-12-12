# JOIN TABLE FOR APPLICATIONS AND PETS

class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_uniqueness_of :pet_id, scope: :application_id # flipped also works
end
