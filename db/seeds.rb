# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
cities = City.create([{ name: 'London' }, { name: 'Berlin' }, { name: 'New York' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
event_types = EventType.create([{ name:'Hackathon'}, {name:'Startup Job Fair'}, {name:'Startup Workshop'}])

project_types = ProjectType.create([{ name:'WebApp'}, {name:'MobileApp'}, {name:'Hardware'},{name: 'Others'}])