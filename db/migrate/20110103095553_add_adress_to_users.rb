class AddAdressToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :street, :string
    add_column :users, :zip, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :country
    remove_column :users, :city
    remove_column :users, :zip
    remove_column :users, :street
  end
end
