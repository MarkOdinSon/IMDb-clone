# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!([{
               email: 'user@mail.com',
               password: '112233'
              },
              {
                email: 'admin@mail.com',
                password: 'admin112233',
                role: 'admin'
              },
              {
                email: 'super_admin@mail.com',
                password: 'super_admin112233',
                role: 'super_admin'
              }])
p "Created #{User.count} Users"