# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Venue.create(
#     title:  Faker::Company.name,
#     description: Faker::Lorem.paragraph,
#     address: Faker::Address.street_address,
#     # Faker::Address.city,
#     # Faker::Address.state,
#     # Faker::Address.zip_code,
#     street_address: Faker::Address.street_address,
#     locality: Faker::Address.city,
#     region: Faker::Address.state,
#     postal_code: [Faker::Address.zip_code, Faker::Address.postcode].sample,
#     country: Faker::Address.country,
#     latitude: Faker::Address.latitude,
#     longitude: Faker::Address.longitude,
#     email: Faker::Internet.email,
#     telephone: Faker::PhoneNumber.phone_number,
#     url: Faker::Internet.url,
#     closed: [false, true].sample,
#     wifi: [true, false].sample,
#     access_notes: Faker::Lorem.paragraph
# )

User.create!(name: "peng",
             email: "user@test.com",
             password: "password",
             password_confirmation: "password",
             admin: "true",
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end


users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }



begin
  require 'faker'
  require 'factory_girl'
rescue LoadError
  puts "Calagator's seeds require faker and factory_girl."
  puts "Add them to your gemfile and try again."
  exit 1
end

FactoryGirl.define do
  factory :seed_venue, class: Venue do
    title { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    address { "#{Faker::Address.street_address},
                       #{Faker::Address.city},
                       #{Faker::Address.state}
    #{Faker::Address.zip_code}" }
    street_address { Faker::Address.street_address }
    locality { Faker::Address.city }
    region { Faker::Address.state }
    postal_code { [Faker::Address.zip_code, Faker::Address.postcode].sample }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    email { Faker::Internet.email }
    telephone { Faker::PhoneNumber.phone_number }
    url { Faker::Internet.url }
    closed { [false, true].sample }
    wifi { [true, false].sample }
    access_notes Faker::Lorem.paragraph

    trait :with_events do
      after(:create) do |seed_venue|
        create_list(:seed_event, 3, venue_id: seed_venue.id)
      end
    end

  end

  factory :seed_event, class: Event do
    from = 2.years.ago
    to = 2.years.from_now

    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_time {
      [
          Faker::Time.between(2.years.ago, 2.years.from_now),
          Faker::Time.backward(1, :all),
          Faker::Time.forward(1, :all),
          Faker::Time.forward(7, :all)
      ].sample
    }
    created_at { start_time - 1.days }
    end_time { start_time + 3.hours }

    trait :with_venue do
      before(:create) do |seed_event|
        venue = create(:seed_venue)
        seed_event.venue_id = venue.id
      end
    end
  end
end

puts "Seeding database with sample data..."
FactoryGirl.create_list(:seed_venue, 25, :with_events)
FactoryGirl.create_list(:seed_venue, 25)
FactoryGirl.create_list(:seed_event, 25, :with_venue)
FactoryGirl.create_list(:seed_event, 25)