class AddUserIdToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :user_id, :integer
  end

  def self.down
    remove_column :registrations, :user_id
  end
end
