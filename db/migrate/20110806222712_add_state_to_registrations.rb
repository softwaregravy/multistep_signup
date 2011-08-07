class AddStateToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :state, :string
  end

  def self.down
    remove_column :registrations, :state
  end
end
