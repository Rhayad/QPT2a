class AddFieldsToPrestory < ActiveRecord::Migration
  def self.up
  	add_column :prestories, :title, :string
  	add_column :prestoryquests, :title, :string
  end

  def self.down
  end
end
