# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "hoge#{n}" }
    sequence(:created_at) { |n| Time.current + n.hours }
    sequence(:end_time) { |n| Time.zone.tomorrow + n.days }
    user_id { 1 }
    user
  end
end
