# dev packages
#------------------------------
%w(
  git
  gcc
  gcc-c++
  make
  autoconf
  tar
  patch
  openssl-devel
  libxml2-devel
  libxslt-devel
  libyaml-devel
  readline-devel
  zlib-devel
).each do |name|
  package name do
    action :install
  end
end

user "app"

execute  "gpasswd -a vagrant app" do
  not_if "groups vagrant | grep app"
end

execute 'gem install unicorn' do
  not_if 'gem list | grep unicorn'
end

remote_file "/etc/init.d/unicorn" do
  owner "root"
  group "root"
  mode  "755"
end

remote_file "/etc/nginx/conf.d/default.conf"

template "/etc/nginx/conf.d/#{node[:app][:name]}.conf" do
  action :create
  source "./templates/etc/nginx/conf.d/app.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables node[:app]
end

directory "/etc/unicorn" do
  owner "root"
  group "root"
  mode  "755"
end

template "/etc/unicorn/#{node[:app][:name]}.conf" do
  action :create
  source "./templates/etc/unicorn/app.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables node[:app]
end

directory node[:app][:path] do
  owner "app"
  group "app"
  mode "775"
end

%w(
  releases
  repo
  shared
).each do |dir|
  directory "#{node[:app][:path]}/#{dir}" do
    owner "app"
    group "app"
    mode "775"
  end
end

[
  "#{node[:app][:log_path]}",
  "#{node[:app][:log_path]}/nginx",
].each do |dir|
  directory dir do
    owner "app"
    group "app"
    mode "775"
  end
end

service "unicorn" do
  action [:enable]
end

if node[:platform] == "centos"
  package "http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm" do
    not_if "rpm -q mysql-community-release-el7-5.noarch"
  end
end

%w(
  mysql-community-client
  mysql-community-devel
).each do |name|
  package name do
    action :install
  end
end

