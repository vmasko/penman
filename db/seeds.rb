# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

%w(World Politics Travel Lifestyle).each do |name|
  Category.find_or_create_by(name: name)
end

15.times do
  Post.create(
    title:   Faker::Hipster.sentence,
    content: Faker::Hipster.paragraph(10),
    categories: Category.all.sample(2),
    publish: '1'
    )
end
