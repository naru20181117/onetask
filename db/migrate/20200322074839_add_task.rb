class AddTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :end_time, :datetime, default: -> { "now()" }, null: false
  end
end

