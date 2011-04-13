class CreateTodoUsers < ActiveRecord::Migration
  def self.up
    create_table :todo_users do |t|
      t.integer :user_id
      t.integer :todo_id
      t.timestamps
    end
      add_index :todo_users, :user_id
      add_index :todo_users, :todo_id
  end

  def self.down
    drop_table :todo_users
  end
end
