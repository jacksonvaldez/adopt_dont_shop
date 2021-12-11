require 'rails_helper'

RSpec.describe 'Applications Index Page' do

  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', rank: 4, city: 'Denver')
    @pet_1 = Pet.create!(adoptable: true, breed: "Yorkie", name: 'Puffles', age: 5, shelter_id: @shelter_1.id)
    @application_1 = Application.create!(
                                      applicant: 'John Wick',
                                      applicant_address: '1000 Street',
                                      description: 'im a good owner',
                                      status: 'Pending'
                                      )
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    visit '/applications'

  end

  it 'displays a link to visit each applications show page' do
    expect(page).to have_link("View Application (John Wick)")
    click_link("View Application (John Wick)")
    expect(page).to have_current_path("/applications/#{@application_1.id}")
  end

  it 'displays a link to create a new application' do
    expect(page).to have_link("New Application")
    click_link("New Application")
    expect(page).to have_current_path("/applications/new")
  end

end
