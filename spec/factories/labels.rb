# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    name { "HTML" }
    trait :label_css do
      name { "CSS" }
    end
    trait :label_js do
      name { "JS" }
    end
  end
end
