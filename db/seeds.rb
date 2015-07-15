# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create({name: "Regular", description: "Can read events and buy tickets"})
Role.create({name: "Curator", description: "Can read and create events. Can update and destroy own events"})
Role.create({name: "Subcurator", description: "Can read and create events. Can update and destroy own events"})
Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})

User.create({name: "Admin", password: "admin1123", email: "admin@tixipro.my", role_id: '3'})
User.create({name: "Regular", password: "regular1123", email: "regular@tixipro.my", role_id: '1'})
User.create({name: "Curator", password: "curator1123", email: "curator@tixipro.my", role_id: '2'})
User.create({name: "Subcurator", password: "subcurator1123", email: "subcurator@tixipro.my", role_id: '4'})
