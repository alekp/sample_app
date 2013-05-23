namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin) # http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-attr_accessible_review
    
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
     # admin  colum by default is set to false  in migration script 20130523112100_add_admin_to_users.rb
    end
  end
end