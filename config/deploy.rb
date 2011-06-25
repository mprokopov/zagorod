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

role :app, "colo.it-premium.com.ua"
role :web, "colo.it-premium.com.ua"
role :db,  "colo.it-premium.com.ua", :primary => true

after :deploy, "passenger:restart"


set :app_symlinks, %w( photo )

desc "Symlinks the :app_symlinks directories from current/public to shared/public"
task :symlink_public do
   if app_symlinks
     app_symlinks.each do |link|
       run "ln -nfs #{shared_path}/public/#{link} #{current_path}/public/#{link}"
     end
   end
end

desc "Copy production assets"
task :copy_assets do
   download "#{shared_path}/public/assets", "public/assets", :once=>true, :recursive=>true
end

namespace :deploy do
   task :after_symlink, :roles => [:app, :web] do
     symlink_public
   end
   desc "Restart Application"
   task :restart do
     run "touch #{current_path}/tmp/restart.txt"
   end
end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end