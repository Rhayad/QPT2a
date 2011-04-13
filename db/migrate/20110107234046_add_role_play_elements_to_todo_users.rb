class AddRolePlayElementsToTodoUsers < ActiveRecord::Migration
  def self.up
    add_column :todo_users, :isQueueDone, :boolean
    add_column :todo_users, :isProved, :boolean
    add_column :todo_users, :gold, :integer
    add_column :todo_users, :xp, :integer
  end

  def self.down
    remove_column :todo_users, :xp
    remove_column :todo_users, :gold
    remove_column :todo_users, :isProved
    remove_column :todo_users, :isQueueDone
  end
end
