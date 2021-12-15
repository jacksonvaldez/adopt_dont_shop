class Application < ApplicationRecord
  validates :applicant, presence: true
  validates :applicant_address, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates_uniqueness_of :applicant

  # Many to Many associations
  has_many :application_pets
  has_many :pets, through: :application_pets
  has_many :shelters, through: :pets

  def pet_statuses
    pet_statuses = {}
    self.pets.each do |pet|
      status = ApplicationPet.find_by(application_id: self.id, pet_id: pet.id).status
      pet_statuses[pet.id] = [pet.name, status]
    end
    pet_statuses
  end
end
