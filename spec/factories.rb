# https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid { |n| n }
    name 'Some guy'
    nickname 'smgy'
    email 'someguy@facebook.com'

    oauth_token { |n| n }
    oauth_expires_at 2.months.from_now

    role "basic"

    factory :teacher do
      role "teacher"
    end

    factory :admin do
      role "admin"
    end
  end

  factory :course do
    abbreviation { |n| "INF100#{n}" }
    name { |n| "Programação #{n}" }
    credits 4
  end

  factory :exam do
    course
    year { |n| (2000 + n/2).to_i }
    semester { |n| (n % 2) +1 }
    number { |n| (n % 4) + 1 }
  end

  factory :chat_message do
    course
    user
    text "This is some text."
  end
end