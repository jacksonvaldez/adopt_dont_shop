# JOIN TABLE FOR APPLICATIONS AND PETS

class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
end
