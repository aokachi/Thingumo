FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テスト%03d" % n }
    sequence(:email) { |n| "thingumo#{n}@thingumo.jp" }
    sex { [1, 2].sample } # ランダムに選択
    birthday { "1990-01-01" }
    avatar { nil }
    self_introduction { nil }
    total_points { 0 }
    password { '1234abcd' }
    password_confirmation { '1234abcd' }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    remember_created_at { nil }
    created_at { "2024-04-01 00:00:00" }
    updated_at { "2024-04-01 00:00:00" }
  end
end
