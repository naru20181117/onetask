class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, limit: 20
      t.string :memo, null: false, limit: 50

      t.timestamps
    end
  end
end
