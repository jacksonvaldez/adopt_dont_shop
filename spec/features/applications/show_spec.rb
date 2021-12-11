require 'rails_helper'

RSpec.describe 'Application Show Page' do

  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', rank: 4, city: 'Denver')
    @pet_1 = Pet.create!(adoptable: true, breed: "Yorkie", name: 'Puffles', age: 5, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: false, breed: "Pug", name: 'Bear', age: 7, shelter_id: @shelter_1.id)
    @application_1 = Application.create!(
                                      applicant: 'John Wick',
                                      applicant_address: '1000 Street',
                                      description: 'im a good owner',
                                      status: 'Pending'
                                      )
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    visit "/applications/#{@application_1.id}"

  end

  it 'displays application info' do
    expect(page).to have_content("Applicant: John Wick") # Name of the Applicant
    expect(page).to have_content("Applicant Address: 1000 Street") # Applicant's address
    expect(page).to have_content("Description: im a good owner") # description
    expect(page).to have_content("Pet Names: Puffles & Bear &") # pet names
    expect(page).to have_content("Status: Pending") # status
  end

end
