class SessionsController < ApplicationController
     
    # Create session - login
    def create
        user = User.authenticate(params[:session][:email], params[:session][:password])
        if user.nil?
          flash.now[:error] = "Invalid email/password combination."
          render 'new'
        else
          # Sign the user in and redirect to the user's show page.
          sign_in(user)
          redirect_to current_user
        end
    end
end
