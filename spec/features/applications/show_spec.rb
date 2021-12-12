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
                                      status: 'In Progress'
                                      )
    visit "/applications/#{@application_1.id}"

  end

  it 'displays application info' do
    expect(page).to have_content("Applicant: John Wick") # Name of the Applicant
    expect(page).to have_content("Applicant Address: 1000 Street") # Applicant's address
    expect(page).to have_content("Description: im a good owner") # description
    expect(page).to have_content("Pet Names:") # pet names
    expect(page).to have_content("Status: In Progress") # status
  end

  it 'displays a mini search form to add a pet to the application' do
    expect(page).to have_content('Add a pet to this application:')
    expect(page.has_field?(:search_text)).to eq(true)
    expect(page).to have_button('Find Pet')
  end

  it 'when pet search is ran, it takes you to currect route' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    expect(current_path).to eq("/applications/#{@application_1.id}")
  end

  it 'when pet search is ran, it displays any pets that matches the search' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    expect(page).to have_content('Puffles')
  end

  it 'when pet search is ran, and you add a pet, it saves to the form' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    click_button('Adopt This Pet')
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("Pet Names: Puffles")
  end

  it 'does not display an application submission option if no pets are added' do
    expect(page).to_not have_button("Submit Application")
    expect(page).to_not have_content("Why would you be a good owner?:")
  end

  it 'displays application submission option if pets are added' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    click_button('Adopt This Pet')
    expect(page).to have_button("Submit Application")
    expect(page).to have_content("Why would you be a good owner?:")
  end

  it 'updates status after submitting' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    click_button('Adopt This Pet')
    fill_in(:owner_description, with: 'i like dog')
    click_button('Submit Application')
    expect(page).to have_content("Status: Pending")
  end

  it 'no longer displays ability to add pets after submitting' do
    fill_in(:search_text, with: 'Puffles')
    click_button('Find Pet')
    click_button('Adopt This Pet')
    fill_in(:owner_description, with: 'i like dog')
    click_button('Submit Application')

    expect(page).to_not have_content('Add a pet to this application:')
    expect(page.has_field?(:search_text)).to eq(false)
    expect(page).to_not have_button('Find Pet')
  end

end
