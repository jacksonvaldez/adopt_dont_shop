require 'rails_helper'

RSpec.describe 'Admin Index Page' do
  
  before(:each) do
    visit '/admin'
  end

  it 'displays a link to preview all applications' do
    expect(page).to have_link("View Applications")
    click_link("View Applications")
    expect(page).to have_current_path('/admin/applications')
  end

end
