class Application < ApplicationRecord
  validates :applicant, presence: true
  validates :applicant_address, presence: true
  validates :description, presence: true
  validates :status, presence: true

  # Many to Many associations
  has_many :application_pets
  has_many :pets, through: :application_pets
end
