class TodosController < ApplicationController

	before_filter :authenticate
    before_filter :getGroupId, :only => [:new, :create, :edit]
    before_filter :getProjectId, :only => [:new, :create, :edit]
    before_filter :getTodoId, :only => [:edit, :update, :destroy, :isAuthorizedUser]
    before_filter :isAuthorizedUser, :only => [:edit, :update, :destroy]

	# ------------------------------------------------
    # Creates a new entry (form)
    def new
        @todo = Todo.new
        todo_user = @todo.todo_users.build
        
        @groupmembers = GroupMember.new.listUser(params[:group_id])

        @preId = "0"
        @preTitle = ""
        @preText = ""
        lastPreQuestId = 0
        if @project.prestories_id > 0
            getLastTodo = Todo.where("project_id = ?", @project.id).last
            if getLastTodo
                lastPreQuestId = getLastTodo.prestories_quest_id
            end
            
            @t = Prestoryquest.find_by_prestories_id_and_position(@project.prestories_id, lastPreQuestId + 1)            
            if @t
                @preId = @t.id
                @preTitle = @t.title
                @preText = @t.description
            else
                @preText = "No more quests in predefined adventure"
            end        
        end
    end
    
    def edit
        todo_user = @todo.todo_users
        @groupmembers = GroupMember.new.listUser(params[:group_id])
    end
    # ------------------------------------------------
    # Database Actions
    def create
        @todo         = @group.todos.build(params[:todo])
        @todo.project = @project
        @project      = @todo.project

        @todo.save
        
        # Create TodoUser
        @todoAssign = @todo.todo_users.build(:todo_id => @todo.id, :user_id => params[:assign], :gold => params[:todo][:todo_users_attributes]["0"][:gold], :xp => params[:todo][:todo_users_attributes]["0"][:xp]) if !@todo.nil?
        if @todoAssign.save
            redirect_to group_project_path(params[:group_id], params[:project_id])
            flash[:success] = "Todo created!"
        else
            @groupmembers = GroupMember.new.listUser(params[:group_id])  
            flash[:error] = "Couldn't create new Todo !"
            render 'new'
        end
    end
    
    def update
        if @todo.update_attributes(params[:todo])
            
            @todoUser = TodoUser.find(params[:todo][:todo_users_attributes]["0"][:id])
            if  @todoUser.update_attributes(params[:todo][:todo_users_attributes]["0"])
                # --------------------
                # Level Avatar Up & give skills if isProven = 1
                if params[:todo][:todo_users_attributes]["0"][:isProved] == '1'
                    Avatar.new.setAvatarSkillPoints(params[:todo][:user_id], params[:todo][:todo_users_attributes]["0"][:xp])
                end
                # --------------------
                redirect_to group_project_path(params[:group_id], params[:project_id])
                flash[:notice] = "Todo updated !"
            else
                flash[:error] = 'Didnt work to update todoUser'
                render 'edit'
            end
        else
           flash[:error] = 'Didnt work to update todo'
           render 'edit'
        end
    end
    
    def destroy
        @todo.destroy
        redirect_back_or group_projects_path
    end

    # ------------------------------------------------
    # Set isQueueDone in todo_users to true, so that master knows that he can aprove it
    def pushToQueue
        @todouser = TodoUser.find(params[:id])
        if @todouser.update_attributes(:isQueueDone => true)
            flash[:success] = 'Quest is waiting for approvement !'
        else
            flash[:error] = 'Error while updating status of quest'
        end
        redirect_to group_project_path(params[:group_id], params[:project_id])            
            
    end

    # ------------------------------------------------
    private
        # Checks if user is allowed to change the todo
        def isAuthorizedUser         
            redirect_to groups_path unless current_user.id == @todo.user_id
        end

        def getGroupId
            @group = Group.find(params[:group_id])
        end

        def getProjectId
            @project = Project.find(params[:project_id])
        end

        def getTodoId
            @todo = Todo.find(params[:id])
        end
end