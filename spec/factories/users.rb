# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    sequence(:password_digest) { |n| "password#{n}" }
  end
end
