class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true
  validates_uniqueness_of :name

  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_name
    self.find_by_sql("SELECT * FROM shelters ORDER BY lower(name) DESC;")
  end

  def self.with_pending_applications
    # self.find_by_sql("
    #   SELECT DISTINCT shelters.* FROM shelters
    #     JOIN pets ON pets.shelter_id = shelters.id
    #     JOIN application_pets ON application_pets.pet_id = pets.id
    #     JOIN applications ON application_pets.application_id = applications.id
    #     WHERE applications.status = 'Pending' ;
    #   ")
    self.select('shelters.*')
      .joins('JOIN pets ON pets.shelter_id = shelters.id')
      .joins('JOIN application_pets ON application_pets.pet_id = pets.id')
      .joins('JOIN applications ON application_pets.application_id = applications.id')
      .where('applications.status' => 'Pending')
      .distinct
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
