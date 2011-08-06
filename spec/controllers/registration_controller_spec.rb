require 'spec_helper'

describe RegistrationController do

  describe "GET 'start'" do
    it "should be successful" do
      get 'start'
      response.should be_success
    end
  end

  describe "GET 'email'" do
    it "should be successful" do
      get 'email'
      response.should be_success
    end
  end

  describe "GET 'age'" do
    it "should be successful" do
      get 'age'
      response.should be_success
    end
  end

end
