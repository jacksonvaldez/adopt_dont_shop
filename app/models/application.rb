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
    ApplicationPet.where(application_id: self.id)
      .joins('JOIN pets ON pets.id = application_pets.pet_id')
      .select('pets.id AS pet_id, pets.name, application_pets.status')
      # binding.pry
  end
end
