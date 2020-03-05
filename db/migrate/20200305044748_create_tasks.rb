class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, limit: 20
      t.string :memo, limit: 100

      t.timestamps
    end
  end
end
