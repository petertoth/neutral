FactoryGirl.define do
  factory :post do
    title "Title"
  end

  factory :vote, class: Neutral::Vote do
    association :voteable, factory: :post
    association :voter, factory: :user
    value { rand(0..1) }
  end

  factory :user do
    sequence :username do
      FFaker::Name.name
    end 
    password 'secret'
  end
end
