# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { "hoge" }
    memo { "example_memo" }
  end
end
