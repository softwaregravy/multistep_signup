# == Schema Information
#
# Table name: registrations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  age        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'transitions'
class Registration < ActiveRecord::Base
  include ActiveRecord::Transitions 

  has_one :user

  state_machine do 
    state :start, :exit => lambda {|reg| reg.errors.clear }
    state :email, :exit => lambda {|reg| reg.errors.clear }
    state :age, :exit => lambda {|reg| reg.errors.clear }
    state :complete, :enter => :register_user 

    event :next do 
      transitions :from => :start, :to => :email, :guard => :guard_to_email 
      transitions :from => :email, :to => :age, :guard => :guard_to_age
      transitions :from => :age, :to => :complete, :guard => :guard_to_complete
    end 
  end 

  def register_user 
    self.user = User.auto_create(self)
    self.save!
  end 

  def guard_to_email 
    require_name
  end 


  private 
  def require_name 
    errors.add(:name, "Name is required") unless name.present?
    errors.empty?
  end 

  def require_email
    errors.add(:email, "Email is required") unless email.present?
    errors.empty?
  end 

  def require_age
    errors.add(:age, "Age is required") unless age.present?
    errors.empty?
  end 
end
