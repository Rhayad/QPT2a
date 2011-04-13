module SessionsHelper

    def sign_in(user)
        cookies.permanent.signed[:remember_token] = [user.id, user.salt]
        current_user = user                            #The purpose of this line is to create current_user, accessible in both controllers and views, which will allow constructions such as, current_user.name
        #redirect_back_or_default(pages_home_path)     # redirects the user to store_location - somehow doesnt work
    end

    def current_user
        @current_user ||= user_from_remember_token   # calls the user_from_remember_token method the first time current_user is called
    end
    
    def signed_in?
        !current_user.nil?
    end
    
    # Logout
    def sign_out
        cookies.delete(:remember_token)
        current_user = nil
    end
    
    # Destroy session, go to home page
    def destroy
        sign_out
        redirect_to pages_home_path
    end
    
    # -----------------------------------------------
    def authenticate
        deny_access unless signed_in?
    end

    # User wants to see a page but is not logged in -> redirect to login-site
    def deny_access
        store_location   # This method stores a URL in a session variable for future reference
        redirect_to signin_path, :notice => "Please sign in to access this page."
    end
    
    # -----------------------------------------------
    private
    
        def user_from_remember_token
          User.authenticate_with_salt(*remember_token)
        end
        
        def remember_token
          cookies.signed[:remember_token] || [nil, nil]
        end
end
