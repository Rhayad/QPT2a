set :application, "quject"
set :repository,  "ssh://fhs31480@mediacube.at/var/www/virthosts/francoisonrails@multimediatechnology.at/gitrepo"

set :scm, :git
#==========================
set :branch, "master"
set :deploy_to, "var/www/virthosts/francoisonrails@multimediatechnology.at"
set :user, "fhs31480"
set :use_sudo, false

default_run_options[:pty] = true
require "bundler/capistrano"
#==========================

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :servername, "multimediatechnology.at"
role :web, servername #"your web-server here"                          # Your HTTP server, Apache/etc
role :app, servername #"your app-server here"                          # This may be the same as your `Web` server
role :db,  servername, :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

   task :copy_config do
   	run "cp #{shared_path}/config/database.yml #{release_path/config/database.yml}"
   end

 end

 after "deploy:update_code", "deploy:copy_config"