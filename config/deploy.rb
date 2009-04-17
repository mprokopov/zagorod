set :application, "zagorod"
set :repository,  "nexus@colo2.it-link.com.ua:/home/nexus/repo/zagorod.git"
set :scm, :git
set :branch, "master"
ssh_options[:paranoid]=false

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/www/#{application}"
set :deploy_via, :remote_cache
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :use_sudo, false
set :user, "nexus"

role :app, "colo2.it-link.com.ua"
role :web, "colo2.it-link.com.ua"
role :db,  "colo2.it-link.com.ua", :primary => true

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"
