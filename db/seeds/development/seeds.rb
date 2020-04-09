# frozen_string_literal: true

5.times do |n|
  Task.create!(
    name: "Task#{n + 1}",
    memo: "Memo#{n + 100}",
    end_time: Time.current.tomorrow + n.hours,
    status: 0,
    priority: 0
  )
end

5.times do |n|
  Task.create!(
    name: "task#{n + 1}",
    memo: "memo#{n + 100}",
    end_time: Time.current.tomorrow + n.days,
    status: 1,
    priority: 1
  )
end

5.times do |n|
  Task.create!(
    name: "TASK#{n + 1}",
    memo: "MEMO#{n + 100}",
    end_time: Time.current.tomorrow + n.weeks,
    status: 2,
    priority: 2
  )
end
