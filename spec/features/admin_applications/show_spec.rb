require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do

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
    visit "/admin/applications/#{@application_1.id}"

  end

  it 'displays an approve & reject button next to each pet' do
    expect(page).to have_button('Approve')
    expect(page).to have_button('Reject')
  end

  it 'redirects back to show page after clicking the approve button' do
    click_button('Approve')
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
  end

  it 'redirects back to show page after clicking the reject button' do
    click_button('Reject')
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
  end

  it 'no longer displays the buttons next to each pet after clicking one' do
    click_button('Approve')
    expect(page).to_not have_button('Approve')
    expect(page).to_not have_button('Reject')
  end

  it 'displays approved next to each pet after clicking the approve button' do
    click_button('Approve')
    expect(page).to have_content('Puffles (Approved)')
    expect(page).to_not have_content('Puffles (Rejected)')
  end

  it 'displays rejected next to each pet after clicking the reject button' do
    click_button('Approve')
    expect(page).to have_content('Puffles (Approved)')
    expect(page).to_not have_content('Puffles (Rejected)')
  end

end
