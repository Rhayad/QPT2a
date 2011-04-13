class AddSkillsColumnToAvatar < ActiveRecord::Migration
  def self.up
    add_column :avatars, :skillPoints, :integer, :default => 0
  end

  def self.down
    remove_column :avatars, :skillPoints
  end
end
