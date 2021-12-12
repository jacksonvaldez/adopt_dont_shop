require 'rails_helper'


RSpec.describe 'Admin Shelters Index Page' do

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_3 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    visit '/admin'
    click_link 'View Shelters'
  end

  it 'displays shelters in order by reverse alphabetical order of name' do
    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('RGV animal shelter').to appear_before('Aurora shelter')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
  end

end
