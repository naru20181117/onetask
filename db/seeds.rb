# frozen_string_literal: true

environment = Rails.env
path = Rails.root.join("db/seeds", environment, "seeds.rb")

if File.exist?(path)
  require path
end
puts "#{path}..."
