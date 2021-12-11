class Application < ApplicationRecord
  validates :applicant, presence: true
  validates :applicant_address, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates_uniqueness_of :applicant

  # Many to Many associations
  has_many :application_pets
  has_many :pets, through: :application_pets
end
