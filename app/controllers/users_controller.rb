# QUEJECT
# made by Jonathan Riedl (MMA Master), Marcus Kauth (MMT09), Francois Weber (MMT09)
class UsersController < ApplicationController
    
    before_filter :getUserID, :only => [:show , :edit, :update, :password, :updatePassword ]
    
    # ----------------------------------------------------------
    def new
        @user = User.new
    end
  
    def show
        @avatar = @user.avatar
        
        avatar = Avatar.new
        @userXp     = avatar.getAvatarXp(@user.id)
        @userLevel  = avatar.getLevel(@user.id)
        @userGold   = avatar.getAvatarGold(@user.id) 

        @skillPoints = avatar.getSkillPoints(@user.id)
    end
    
    def edit
        unless signed_in? and @user == current_user
            redirect_to pages_home_path
        end
    end

    def password
    end
   
    # ----------------------------------------------------------   
    # Insert new User to Database
    def create
        @user = User.new(params[:user])
        if @user.save
            @avatar = Avatar.new(:user_id => @user.id)
            @avatar.save
            sign_in @user
            flash[:success] = "Welcome to Queject !"
            redirect_to @user 
        else
            flash[:error] = "Error while creating new user"
            render 'new'
        end
    end  

    def update
        if @user.update_attributes(params[:user])
            flash[:success] = "Profile updated !"
            redirect_to user_path
        else
            flash[:error] = "Error while updating !"
            render 'edit'
        end
    end
    
    def updatePassword
        newEncryptedPw = @user.encrypt(params[:user][:password])
        if @user.check_password?(params[:user][:password_old])
            if @user.update_attributes(:encrypted_password => newEncryptedPw)
                flash[:success] = "Password updated ! #{newEncryptedPw}"
                render 'password'
            else
                flash[:error] = "Error while updating password !"
                render 'password'
            end        
        else
            flash[:error] = "Passwords dont match #{newEncryptedPw}!"
            render 'password'
        end
    end

    # Saves skillPoint
    def decreaseAvatarPoints
        # Remove Skill Points
        @avatar = Avatar.find_by_user_id(current_user.id)
        currentSkillsPoints = Integer(@avatar.skillPoints)
        if currentSkillsPoints > 0
            newPoints = currentSkillsPoints - 1            
            @avatar.update_attribute(:skillPoints, newPoints)                    
        end
        respond_to do |format|
            format.html { redirect_to(user_url) }
            format.js   { render :nothing => true }
        end
    end

    def addSkillToAvatar
        @avatar = Avatar.find_by_user_id(current_user.id)

        return false unless @avatar.skillPoints != 0

        avatarAttribute = params[:skillPoint][:value]
        
        if avatarAttribute == "strength"
            newSkill = @avatar.strength + 1
        elsif avatarAttribute == "ability"
            newSkill = @avatar.ability + 1
        elsif avatarAttribute == "intelligence"
            newSkill = @avatar.intelligence + 1
        else
            newSkill = @avatar.endurance + 1
        end

        @avatar.update_attribute(avatarAttribute, newSkill)
        
         respond_to do |format|
            format.html { redirect_to(user_url) }
            format.js   { render :nothing => true }
        end
    end
    # ----------------------------------------------------------
    private
        # Checks if the user is logged in and finds User by ID
        def getUserID
            if signed_in?                
                if params[:id].empty?
                    uid = current_user.id
                else
                    uid = params[:id]
                end
                @user = User.find(uid)
            else
                redirect_to pages_home_path
            end
        end 
end