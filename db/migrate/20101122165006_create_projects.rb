class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
    add_index :projects, :user_id
    add_index :projects, :group_id
  end

  def self.down
    drop_table :projects
  end
end
