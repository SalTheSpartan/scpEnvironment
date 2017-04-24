#
# Cookbook:: rails-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# include_recipe 'apt'
package 'nginx'
include_recipe 'nodejs'
include_recipe 'git'
include_recipe "build-essential"
include_recipe "system::install_packages"
include_recipe 'ruby_build'
include_recipe 'ruby_rbenv::system'
include_recipe 'ruby_rbenv::user'

# rbenv_ruby "2.4.0"
# rbenv_global "2.4.0"

# include_recipe "postgresql::client"
# include_recipe 'postgresql::server'
# include_recipe "database::postgresql"

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/nginx/sites-available/default' do
  source 'nginx.default.erb'
  notifies :reload, "service[nginx]"
end
#test
execute 'Install bundler' do
  command 'sudo apt install ruby-bundler -y'
end

execute 'Install rails' do
  command 'sudo apt install ruby-railties -y'
end

execute 'Install ruby-dev' do
  command 'sudo apt-get install ruby-dev zlib1g-dev liblzma-dev -y'
end

execute 'Install hidden dependencies' do
  command 'sudo apt-get install libpq-dev -y'
end
