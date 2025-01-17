require 'rails_helper'

RSpec.describe 'New Application Form' do

  before(:each) do
    visit '/applications/new'
  end

  it 'redirects back to form if one of the required fields are not filled' do
    click_button('Submit Application')
    expect(current_path).to eq('/applications/new')
  end

  it 'displays error message if one of the required fields are not filled' do
    click_button('Submit Application')
    expect(page).to have_content('Error: You did not fill in all required fields')
  end

  it 'redirects to correct path after submitting' do
    fill_in :applicant_name, with: 'Random Name'
    fill_in :street_address, with: '12345 Long Street'
    fill_in :city, with: 'Englewood'
    fill_in :state, with: 'Colorado'
    fill_in :zip_code, with: '80648'
    click_button('Submit Application')

    expect(page).to have_current_path("/applications/#{Application.last.id}")
  end

end
