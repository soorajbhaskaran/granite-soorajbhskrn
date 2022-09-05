# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    task
    content { Faker::Lorem.sentence[50] }
  end
end
