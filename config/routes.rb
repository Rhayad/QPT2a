LoginTest::Application.routes.draw do

    resources :sessions, :only => [:new, :create, :destroy]
    match '/signin',  :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'
        
    resources :users
    match '/search',  :to => 'users#findUserByUsername'
    match '/signup',  :to => 'users#new'
    match '/password',  :to => 'users#password', :via => "get"
    match '/updatePassword',  :to => 'users#updatePassword', :via => "put"
    
    resources :groups do
        resources :groupmembers, :only => [:update], :to => 'groups#joinGroup'       
        resources :groupmembers, :only => [:destroy], :to => 'groups#leaveGroup' 
        post "/find",  :to => 'groups#findByUsername'
        put "/join",  :to => 'groups#joinGroup' 
        resources :invite, :only => [:create], :to => 'groups#inviteUserToGroup'
        resources :projects do
            resources :todos do
                resources :check, :only => [:update], :to => 'todos#pushToQueue'
            end
        end
    end

    get "pages/register"
    get "pages/home"
    get "pages/imprint"
    match '/', :to => 'pages#home'
    put "/addSkill", :to => 'users#addSkillToAvatar'
    put "/decreasepoints", :to => 'users#decreaseAvatarPoints'

end
