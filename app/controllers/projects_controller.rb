# QUEJECT
# made by Jonathan Riedl (MMA Master), Marcus Kauth (MMT09), Francois Weber (MMT09)

class ProjectsController < ApplicationController

    before_filter :authenticate
    before_filter :getGroupID, :only => [:index , :show, :new, :create, :isUserMemberOfGroup]
    before_filter :getProjectID, :only => [:show, :edit, :update, :destroy]
    before_filter :isUserMemberOfGroup, :only => [:index, :show]
    before_filter :isAuthorizedUser, :only => [:destroy, :edit, :update]
    
    # ------------------------------------------------
    def new
        @project = Project.new
        @prestories = Prestory.all
    end

    def index       
        @project = @group.projects
        @groupmember = @group.group_members
    end
    
    def show
        @todo = @project.todos
        if @project.prestories_id > 0
            @t = Prestory.find(@project.prestories_id)
            @project.teaser = @t.teaser
        end

        # Project Member can only see their assigned todos
        if current_user.id != @project.user_id
            @todouser = TodoUser.joins(:todo).where('todos.project_id' => @project.id, 'todo_users.user_id' => current_user.id)        
        # Master can see all Todos of ever user
        else
            @todouser = TodoUser.joins(:todo).where('todos.project_id' => @project.id)
        end
    end
    
    def edit
    end
    # ------------------------------------------------
    def create
        postValues = params[:project]

        # Check if Prestory
        preStory = params[:prestory]
        if preStory != "0"
            addHash = {:prestories_id => preStory }
            postValues.merge!(addHash)
        end

        @project = @group.projects.build(postValues)
        if @project.save
          redirect_to group_projects_path
          flash[:success] = "Project created!"
        else
          flash[:error] = "Couldn't create new Project !"
          render 'new'
        end
    end
    
    def update
        if @project.update_attributes(params[:project])
            redirect_to group_project_path(params[:group_id], params[:id])
            flash[:notice] = 'Project updated !'
        else
           flash[:error] = 'Didnt work to update project'
           render 'edit'
        end
    end

    def destroy
        @project.destroy
        redirect_back_or group_projects_path
    end
    # ------------------------------------------------
    private
        # Checks if user owns this project
        def isAuthorizedUser
            redirect_to groups_path unless current_user.id == @project.user_id
        end

        # Redirects User if he doesn't belong to the group or is not owner of the group
        def isUserMemberOfGroup        
            redirect_to groups_path unless !GroupMember.userIsAlreadyInGroup(params[:group_id], current_user.id)
        end

        def getGroupID
                @group = Group.find(params[:group_id])            
        end

        def getProjectID
            @project = Project.find(params[:id])            
        end
end