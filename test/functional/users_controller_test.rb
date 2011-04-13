require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	
	test "should not create new user without email" do
		post :create, user = { :email => "", :username => "Green", :password => "123456oaoa"}   		
  		assert_equal 'Error while creating new user', flash[:error]
  	end

	test "should redirect not logged in user" do	
    	get :show, :id => "1"
    	assert_response :redirect
    	assert_redirected_to pages_home_path
  	end
end
