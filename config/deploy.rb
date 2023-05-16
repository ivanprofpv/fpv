# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

set :application, "buildfpv"
set :repo_url, "git@github.com:ivanprofpv/fpv.git"
set :pty, false

# Default branch is :master
set :branch, "captcha"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/buildfpv"
set :deploy_user, 'deploy'

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

set :keep_releases, 4
