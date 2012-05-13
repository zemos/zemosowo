namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Admin",
                         email: "admin@ma.pl",
                         password: "1qaz2wsx",
                         password_confirmation: "1qaz2wsx")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      email = "user-#{n+1}@ma.pl"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end