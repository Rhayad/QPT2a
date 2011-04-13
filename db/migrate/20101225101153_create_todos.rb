class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title
      t.integer :user_id
      t.integer :project_id
      t.integer :group_id
      t.boolean :isChecked
      t.date :deadline
      t.date :startdate
      t.float :estimatedTime

      t.timestamps
    end
    add_index :todos, :user_id
    add_index :todos, :project_id
    add_index :todos, :group_id
  end

  def self.down
    drop_table :todos
  end
end
