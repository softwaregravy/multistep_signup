class AddNameAndAgeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :age, :string
  end

  def self.down
    remove_column :users, :age
    remove_column :users, :name
  end
end
