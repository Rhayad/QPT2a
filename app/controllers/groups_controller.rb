# QUEJECT
# made by Jonathan Riedl (MMA Master), Marcus Kauth (MMT09), Francois Weber (MMT09)

class GroupsController < ApplicationController
    
    before_filter :authenticate
    before_filter :isAuthorizedUser, :only  => [:destroy, :edit, :update] 
    before_filter :getGroupId, :only        => [:show, :edit, :update, :destroy, :authorized_user]
    # ------------------------------------------------
    def new
        @group = Group.new if signed_in?
    end

    # Show all groups of user (created, joined, invited)
    def index
        @group          = current_user.groups
        @joinedGroup    = current_user.group_members.joins(:group).where(:isInvited => true)
        @invitedGroup   = current_user.group_members.joins(:group).where(:isInvited => false)
    end
    
    def edit
    end
    # ------------------------------------------------    
    def create
        
        @group = current_user.groups.build(params[:group])
        if @group.save
            flash[:success] = "Group created!"
            redirect_to groups_path
        else
            flash[:error] = "Couldn't create new Group !"
            render 'new'
        end
    end

    def update
        if @group.update_attributes(params[:group])
            redirect_to group_projects_path(params[:id])
        else
           flash[:error] = 'Didnt work'
        end
    end

    def destroy
        @group.destroy
        redirect_to groups_path
    end
    # ------------------------------------------------
    # Search User and lists them to invite
    def findByUsername
        @user = User.new.findUserByUsername(params[:username])
        if @user.empty?
            flash[:error] = "User not found !"
        else
            flash[:success] = "User found !"
        end        
        render 'inviteUser'
    end

    # Invite User to self created Group
    def inviteUserToGroup
        userIsInGroup = GroupMember.userIsAlreadyInGroup(params[:group_id], params[:user_id])
               
        if current_user.id.to_s == params[:user_id]
             flash[:error] = "You are owner of this group !"
        elsif !userIsInGroup
             flash[:error] = "User is already in that group !"
        else                      
            if GroupMember.create(:group_id => params[:group_id], :user_id => params[:user_id])
                flash[:success] = "Member invited to group !"
            else
                flash[:error] = "Couldn't create new invitation !"
            end
        end
        redirect_to group_projects_path(params[:group_id])
    end

    def joinGroup
        @groupMember = GroupMember.find(params[:id])
        if @groupMember.update_attributes(:isInvited => 'true')
            flash[:success] = "joined group !"
        else
            flash[:error] = "Error while joining group"
        end
        redirect_to groups_path
    end

    # User leaves group
    def leaveGroup
        @group = GroupMember.find(params[:id])
        @group.destroy
        if @group.user_id == params[:id].to_s
            flash[:success] = "You left the group !"
        else
            flash[:success] = "User has been kicked !"
        end
        redirect_to groups_path
    end 

    # ------------------------------------------------
    private
        # Checks if user owns this project
        def isAuthorizedUser
            redirect_to groups_path unless current_user.id == @group.user_id
        end

        def getGroupId
            @group = Group.find(params[:id])
        end
end
