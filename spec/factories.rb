FactoryGirl.define do
  # factory :user do
    # name     "Michael Hartl"
    # email    "michael@example.com"
    # password "foobar"
    # password_confirmation "foobar"
  # end
  
  # factory :user do
    # name     "Example User"
    # email    "user@example.com"
    # password "foobar"
    # password_confirmation "foobar"
  # end
  
  # factory :user do
    # name     "Aleksandar Polizovski"
    # email    "polizovski@gmail.com"
    # password "foobar"
    # password_confirmation "foobar"
  # end
  
  # Ch 9 Factory setup
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  
  # Ch 10 
  factory :micropost do
    content "Lorem ipsum"
    user
  end
    
end