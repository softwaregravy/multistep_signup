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
#  state      :string(255)
#

require 'transitions'
class Registration < ActiveRecord::Base
  include ActiveRecord::Transitions 

  belongs_to :user

  validates_presence_of :name

  state_machine do 
    state :email, :exit => lambda {|reg| reg.errors.clear }
    state :age, :exit => lambda {|reg| reg.errors.clear }
    state :complete, :enter => :register_user 

    event :next do 
      transitions :from => :email, :to => :age, :guard => :guard_to_age
      transitions :from => :age, :to => :complete, :guard => :guard_to_complete
      # do not allow complete => complete
    end 
  end 

  def register_user 
    password = User.send(:generate_token, 'encrypted_password').slice(0, 6)
    user = User.create!(:name => name, :email => email, :age => age, 
                            :password => password, :password_confirmation => password)
    Notifications.signup(user, password).deliver
    self.user = user
    self.save!
  end 

  def guard_to_age
    require_email
  end 

  def guard_to_complete 
    require_age
  end 

  private 

  def require_email
    errors.add(:email, "Email is required") unless email.present?
    if email.present?
      errors.add(:email, "Email is already taken") if email_in_use?(email)
    end 
    errors.empty?
  end 

  def email_in_use?(email)
    Registration.where(:email => email).count > 1 || User.where(:email => email).count > 0
  end 

  
  def require_age
    errors.add(:age, "Age is required") unless age.present?
    errors.empty?
  end 

end
