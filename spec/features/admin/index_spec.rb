require 'rails_helper'

RSpec.describe 'Admin Index Page' do

  before(:each) do
    visit '/admin'
  end

  it 'displays a link to visit the admin application index page' do
    expect(page).to have_link('View Applications')
    click_link('View Applications')
    expect(page).to have_current_path('/admin/applications')
  end

  it 'displays a link to visit admin shelters index' do
    expect(page).to have_link('View Shelters')
    click_link('View Shelters')
    expect(page).to have_current_path('/admin/shelters')
  end

end
