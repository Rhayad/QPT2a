class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.integer :user_id
      t.integer :strength, :default => 0
      t.integer :intelligence, :default => 0
      t.integer :ability, :default => 0
      t.integer :endurance, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
