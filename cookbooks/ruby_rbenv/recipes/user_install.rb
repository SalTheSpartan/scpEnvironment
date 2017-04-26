#
# Cookbook:: ruby_rbenv
# Recipe:: user_install
#
# Copyright:: 2011-2017, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'ruby_rbenv'

install_rbenv_pkg_prereqs

template '/etc/profile.d/rbenv.sh' do
  source 'rbenv.sh.erb'
  owner 'root'
  mode '0755'
  only_if { node['rbenv']['create_profiled'] }
end

Array(node['rbenv']['user_installs']).each do |rb_user|
  if rb_user['home'].nil?
    next unless ::File.exist?(File.join(node['rbenv']['user_home_root'], rb_user['user']))
  else
    next unless ::File.exist?(rb_user['home'])
  end
  upgrade_strategy  = build_upgrade_strategy(rb_user['upgrade'])
  git_url           = rb_user['git_url'] || node['rbenv']['git_url']
  git_ref           = rb_user['git_ref'] || node['rbenv']['git_ref']
  home_dir          = rb_user['home'] || ::File.join(
    node['rbenv']['user_home_root'], rb_user['user'])
  rbenv_prefix      = rb_user['root_path'] || ::File.join(home_dir, '.rbenv')
  rbenv_plugins     = rb_user['plugins'] || []

  install_or_upgrade_rbenv rbenv_prefix: rbenv_prefix,
                           home_dir: home_dir,
                           git_url: git_url,
                           git_ref: git_ref,
                           upgrade_strategy: upgrade_strategy,
                           user: rb_user['user'],
                           group: rb_user['group'],
                           rbenv_plugins: rbenv_plugins
end
