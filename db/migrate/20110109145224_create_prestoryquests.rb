class CreatePrestoryquests < ActiveRecord::Migration
  def self.up
    create_table :prestoryquests do |t|
      t.integer :prestories_id
      t.string :description
      t.integer :position, :default => 0

      t.timestamps
    end
    add_index :prestoryquests, :prestories_id
  end

  def self.down
    drop_table :prestoryquests
  end
end
