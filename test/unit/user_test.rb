require 'test_helper'
class UserTest < ActiveSupport::TestCase
  	
  	# Registration Test
	test "register a new user" do	
		@user_params = { :username => "Username1", :email => "username1@host.tld", :password => "u1EncryPw", :salt => "8" }
		@user = User.create!(@user_params)
  		assert_equal 1, User.count
 	end

 	# Email Validation Test
 	test "should not save user without email" do
 		@user_params = { :username => "UserNoEmail", :email => "", :password => "u2EncryPw", :salt => "9" }
  		@user = User.create(@user_params)
  		assert !@user.save
	end

 	# Password and confirmation Test
 	test "should not save user if passwords are different" do
 		@user_params = { :username => "UserNoEmail", :email => "mail@bla.de", :password => "u2EncryPw", :password_confirmation => "anderesPw", :salt => "9" }
  		@user = User.create(@user_params)
  		assert !@user.save
	end

	# Login Test
	test "should signin user" do
		@user_params = { :username => "Username1", :email => "username1@host.tld", :password => "u1EncryPw", :salt => "8" }
		@user = User.create!(@user_params)
		
		@loginUser = User.authenticate("username1@host.tld", "u1EncryPw")
  		assert !@loginUser.nil?
 	end

	# Update Test
	test "should change user data" do
		# Create User
		@user_params = { :username => "Username1", :email => "username1@host.tld", :password => "u1EncryPw", :salt => "8" }
		@user = User.create!(@user_params)
		# Get User data (old)
		usernameOld = @user.username
		
		# Update User
		@updateUser = @user.update_attributes(:username => "UsernameNew", :email => "newEmail@host.tld")

		# Compare
		@newUser = User.find_by_email("newEmail@host.tld")
  		assert !@newUser.nil?
  		assert usernameOld != @newUser.username
 	end

end
