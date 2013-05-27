namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # https://getsatisfaction.com/railstutorial/topics/sample_data_rake_cant_populate_my_db_on_chapter_10_4_1
    #rake aborted!
    #undefined local variable or method `admin' for main:Object
    admin = User.create!(name: "Example User",
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
    
    #Ch 10 
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
    
    # Ch 11
    def make_relationships
      users = User.all
      user  = users.first
      followed_users = users[2..50]
      followers      = users[3..40]
      followed_users.each { |followed| user.follow!(followed) }
      followers.each      { |follower| follower.follow!(user) }
    end
    
  end
end