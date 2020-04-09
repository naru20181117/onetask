# frozen_string_literal: true

table_names = %w(

)

table_names.each do |table_name|
  environment = Rails.env

  path = Rails.root.join("db/seeds", environment, table_name + ".rb")
  if File.exist?(path)
    puts "#{table_name}..."
    require path
  end
end
