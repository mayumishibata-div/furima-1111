FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name { "山田" }
    first_name { "一郎"  }
    last_name_kana { "ヤマダ"  }
    first_name_kana { "イチロウ" }
    birthday { Faker::Date.birthday }
  end
end