# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

OrderStatus.create! id: 1, name: "Pending"
OrderStatus.create! id: 2, name: "Completed"
OrderStatus.create! id: 3, name: "Cancelled"

Role.create({name: "Regular", description: "Can read events"})
Role.create({name: "Organizer", description: "Can read and create events. Can update and destroy own events"})
Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})
