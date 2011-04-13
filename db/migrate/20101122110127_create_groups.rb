class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end
    add_index :groups, :user_id
  end

  def self.down
    drop_table :groups
  end
end
