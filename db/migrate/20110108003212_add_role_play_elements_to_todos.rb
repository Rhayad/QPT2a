class AddRolePlayElementsToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :rp_description, :string
    add_column :todos, :rl_description, :string
    add_column :todos, :rp_title, :string
  end

  def self.down
    remove_column :todos, :rp_title
    remove_column :todos, :rl_description
    remove_column :todos, :rp_description
  end
end
