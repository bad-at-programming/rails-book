#### This task will populate a sample or production database with
##  users including 1 admin user, microposts for the first 6 users
##  and followed/follower relationships. The database should be
##  reset before running this task.

namespace :db do
  desc "Fill in database with sample users"
  task :populate => :environment do
    make_users
    make_microposts
    make_relationships
  end
end

  # Populates database with one admin user and 99 normal users

def make_users
  admin = User.create!(name: "Example User",
                       email: "example@example.com",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

  # Creates 50 microposts for the first 6 users

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

  # Initialize follower/followed relationships. User 1 follows users 2 through 50. Users 2 through 50 follow user 1.

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each {|followed| user.follow!(followed) }
  followers.each {|follower| follower.follow!(user) } 
end

