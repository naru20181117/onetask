class AddTask < ActiveRecord::Migration[6.0]
  def change
<<<<<<< HEAD
    add_column :tasks, :end_time, :datetime, default: -> { 'CURRENT_DATE' }
=======
    add_column :tasks, :end_time, :datetime, default: -> { 'CURRENT_DATE' }, null: false
>>>>>>> refs #15077 end_timeのdefault設定を変更
  end
end
