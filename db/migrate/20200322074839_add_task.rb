class AddTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :end_time, :datetime, null: false, default: Time.zone.today
  end
end

