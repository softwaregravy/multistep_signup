class RegistrationsController < ApplicationController
  respond_to :html 

  def new 
    @registration = Registration.new
  end 

  def create 
    @registration = Registration.new(params[:registration])
    if @registration.save 
      respond_with(@registration, :location => registration_state_path(@registration, @registration.state))
    else 
      flash[:alert] = @registration.errors
      respond_with(@registration)
    end 
  end 

  def edit 
    @registration = Registration.find(params[:id])
    render :template => get_template_for_state(@registration, params[:registration_state])
  end 

  def update 
    @registration = Registration.find(params[:id])
    redirect_to users_path(@registration.user_id) and return if @registration.state == 'complete' 

    if @registration.update_attributes(params[:registration])
      if @registration.next! 
        if @registration.state == 'complete' 
          #can only reach this block on first completion -- or next will have failed
          sign_in(:user, @registration.user)
          redirect_to user_show_path and return 
        else 
          redirect_to registration_state_path(@registration, @registration.state) and return 
        end 
      else 
        flash[:alert] = @registration.errors
        render :template => get_template_for_state(@registration, @registration.state) and return 
      end 
    else 
      flash[:alert] = @registration.errors
      respond_with(@registration, :location => registration_state_path(@registration, @registration.state))
    end 
  end 


  def get_template_for_state(registration, state) 
    # set common variables used in the views
    'registrations/' + state.to_s if ['email', 'age'].include?(state)
  end 

end
