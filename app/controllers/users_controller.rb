class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = current_user
  end

  def destroy 
    current_user.destroy
    puts 'destroying'
    redirect_to root_path
  end 

end
