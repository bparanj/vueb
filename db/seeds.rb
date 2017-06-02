100.times do
  Story.create(plot: Faker::Lorem.sentence, writer: Faker::Name.name, upvotes: Faker::Number.between(1, 200))
end