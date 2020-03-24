# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "hoge#{n}" }
    sequence(:created_at) { |n| Time.current + n.hours }
  end
end
