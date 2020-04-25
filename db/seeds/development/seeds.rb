# frozen_string_literal: true

5.times do |n|
  User.create!(
    name: "User#{n}",
    email: "example#{n}@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  )
end

5.times do |n|
  Task.create!(
    name: "Task#{n + 1}",
    memo: "Memo#{n + 100}",
    end_time: Time.current.tomorrow + n.hours,
    status: 0,
    priority: 0,
    user_id: 1
  )
end

5.times do |n|
  Task.create!(
    name: "task#{n + 10}",
    memo: "memo#{n + 1000}",
    end_time: Time.current.tomorrow + n.days,
    status: 1,
    priority: 1,
    user_id: 1
  )
end

5.times do |n|
  Task.create!(
    name: "TASK#{n + 100}",
    memo: "MEMO#{n + 10000}",
    end_time: Time.current.tomorrow + n.weeks,
    status: 2,
    priority: 2,
    user_id: 1
  )
end
