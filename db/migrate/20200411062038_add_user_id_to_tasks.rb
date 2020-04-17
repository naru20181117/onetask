class AddUserIdToTasks < ActiveRecord::Migration[6.0]
  def up
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
