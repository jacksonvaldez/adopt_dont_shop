require 'rails_helper'


RSpec.describe 'Admin Shelters Index Page' do

  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_3 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @pet_1 = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_3.id)
    @application_1 = Application.create!(applicant: 'John Wick', applicant_address: '1000 Street', description: 'im a good owner', status: 'Pending')
    ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    # @shelter_1 has a pending application
    visit '/admin'
    click_link 'View Shelters'
  end

  it 'displays shelters in order by reverse alphabetical order of name' do
    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('RGV animal shelter').to appear_before('Aurora shelter')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
  end

  it 'displays a section of shelters with pending applications' do
    expect(page).to have_content("Shelters With Pending Applications:\nAurora shelter")
    expect('Shelters With Pending Applications:').to_not appear_before('Fancy pets of Colorado')
    expect('Shelters With Pending Applications:').to_not appear_before('RGV animal shelter')
  end
end
