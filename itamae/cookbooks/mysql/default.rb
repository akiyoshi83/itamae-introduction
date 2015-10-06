if node[:platform] == "centos"
  package "http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm" do
    not_if "rpm -q mysql-community-release-el7-5.noarch"
  end
end

package "mysql-community-server" do
  action :install
end

service "mysqld" do
  action [:enable, :start]
end

remote_file "/etc/my.cnf"

USERNAME = "'#{node[:mysql][:username]}'@'#{node[:mysql][:host]}'"
USERNAME_LOCAL = "'#{node[:mysql][:username]}'@'localhost'"
DBNAME = node[:mysql][:dbname]
PASSWORD = node[:mysql][:password]
execute "mysql -e \"CREATE DATABASE IF NOT EXISTS #{DBNAME};\""
execute "mysql -e \"GRANT ALL ON #{DBNAME}.* TO #{USERNAME} identified by '#{PASSWORD}';\""
execute "mysql -e \"GRANT ALL ON #{DBNAME}.* TO #{USERNAME_LOCAL} identified by '#{PASSWORD}';\""

