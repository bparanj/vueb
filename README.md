rails new vueb --api

gem 'faker'

bundle

https://github.com/stympy/faker

id : integer
plot : string
writer : string
upvotes : integer

rails g scaffold story plot writer upvotes:integer

plot - lorem - Faker::Lorem.sentence
writer - name -  Faker::Name.name    
upvotes - number - Faker::Number.between(1, 200) 

seeds.rb:

100.times do
  Story.create(plot: Faker::Lorem.sentence, writer: Faker::Name.name, upvotes: Faker::Number.between(1, 200))
end

rails db:migrate

rails db:seed

You can now view the JSON : http://localhost:3000/stories

