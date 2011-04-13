class CreatePrestories < ActiveRecord::Migration
  def self.up
    create_table :prestories do |t|
      t.string :teaser

      t.timestamps
    end
    add_column :projects, :prestories_id, :integer, :default => 0
    add_column :todos, :prestories_quest_id, :integer, :default => 0
  end

  def self.down
    drop_table :prestories
  end
end
