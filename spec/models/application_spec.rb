require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do

    @shelter_1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', rank: 4, city: 'Denver')
    @pet_1 = Pet.create!(adoptable: true, breed: "Yorkie", name: 'Puffles', age: 5, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, breed: "Breed", name: 'Leo', age: 7, shelter_id: @shelter_1.id)
    @application_1 = Application.create!(
                                      applicant: 'John Wick',
                                      applicant_address: '1000 Street',
                                      description: 'im a good owner',
                                      status: 'Pending'
                                      )
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_1.id, status: 'Approved')
  end

  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
    it { should have_many(:shelters) }
  end

  describe '#pet_statuses' do
    it 'returns expected hash' do
      expected = {
        @pet_1 => 'Pending',
        @pet_2 => 'Approved'
      }

      expect(@application_1.pet_statuses).to eq(expected)
    end
  end

end
