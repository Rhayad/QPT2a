class CreateGroupMembers < ActiveRecord::Migration
  def self.up
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :isInvited, :default => false

      t.timestamps
    end
      add_index :group_members, :user_id
      add_index :group_members, :group_id
  end

  def self.down
    drop_table :group_members
  end
end
