# https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid 123456789
    name 'Some guy'
    nickname 'smgy'
    email 'someguy@facebook.com'

    oauth_token "CAADxCkwyIr4BAF7lMcszsMCNZBZBitE0qw7g1hQonJuvGiZBK2Q7BiquBa70bWZCRBr8v4OpdxHsKDkZAIXRzmYuAPvUESodJBMJqGFEYl3GfzadNlfJcMvAwlrZBErWvjZBIKD0qY6B3Hczq34wd6eTO8ZCQ27KiCoFZBFjJZC1qvZCdWMOs6fdabc"
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
    teacher
    abbreviation "INF1005"
    name "Programação 1"
    credits 4

    factory :invalid_course do
      abbreviation 'ABC12345'
      name ''
      credits -1
    end
  end


  factory :exam do
    course
    year 2005
    semester 1
    number 4
  end
end