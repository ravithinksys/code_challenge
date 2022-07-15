# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

m1 = Member.create(name: 'Taylor', website: 'https://gist.github.com/tadast/5642683')
m2 = Member.create(name: 'Bart', website: 'https://ahrefs.com/blog/h1-tag')
m3 = Member.create(name: 'Claudia', website: 'https://github.com/jamis/bulk_insert')
m1.friends << m2
m2.friends << m3
