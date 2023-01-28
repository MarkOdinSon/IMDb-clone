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
puts "Created #{User.count} Users"

Category.create!([{
                    name: 'Action'
                  },
                  {
                    name: 'Adventure'
                  },
                  {
                    name: 'Animation'
                  },
                  {
                    name: 'Biography'
                  },
                  {
                    name: 'Comedy'
                  },
                  {
                    name: 'Crime'
                  },
                  {
                    name: 'Documentary'
                  },
                  {
                    name: 'Drama'
                  },
                  {
                    name: 'Family'
                  },
                  {
                    name: 'Fantasy'
                  },
                  {
                    name: 'FilmNoir'
                  },
                  {
                    name: 'GameShow'
                  },
                  {
                    name: 'History'
                  },
                  {
                    name: 'Horror'
                  },
                  {
                    name: 'Music'
                  },
                  {
                    name: 'Musical'
                  },
                  {
                    name: 'Mystery'
                  },
                  {
                    name: 'News'
                  },
                  {
                    name: 'RealityTV'
                  },
                  {
                    name: 'Romance'
                  },
                  {
                    name: 'SciFi'
                  },
                  {
                    name: 'Sport'
                  },
                  {
                    name: 'TalkShow'
                  },
                  {
                    name: 'Thriller'
                  },
                  {
                    name: 'War'
                  },
                  {
                    name: 'Western'
                  }])
puts "Created #{Category.count} Categories"