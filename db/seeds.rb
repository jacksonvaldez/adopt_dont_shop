# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(foster_program: true, name: "Happy Shelter", city: 'Denver', rank: 4)
shelter_2 = Shelter.create(foster_program: false, name: "Big Shelter", city: 'Big City', rank: 7)

pet_1 = Pet.create(adoptable: true, age: 1, breed: "Yorkie", name: 'Dexter', shelter_id: shelter_1.id)
pet_2 = Pet.create(adoptable: false, age: 3, breed: "Poodle", name: 'Max', shelter_id: shelter_1.id)
pet_3 = Pet.create(adoptable: true, age: 8, breed: "Lab", name: 'Buddy', shelter_id: shelter_2.id)
pet_4 = Pet.create(adoptable: false, age: 9, breed: "German Shephard", name: 'Milo', shelter_id: shelter_2.id)

application_1 = Application.create(applicant: 'John Wick', applicant_address: '1000 Street', description: 'im a good owner', status: 'Pending')
application_2 = Application.create(applicant: 'Alan Turing', applicant_address: '750 Street', description: 'im the best owner ever', status: 'Pending')

ApplicationPet.create(pet_id: pet_1.id, application_id: application_1.id)
ApplicationPet.create(pet_id: pet_4.id, application_id: application_1.id)
ApplicationPet.create(pet_id: pet_2.id, application_id: application_2.id)
ApplicationPet.create(pet_id: pet_3.id, application_id: application_2.id)
