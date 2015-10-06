# プラグインでSELinuxを無効化
include_recipe 'selinux::disabled'

# CentOS7では追加のyumリポジトリが必要
if node[:platform] == "centos"
  package "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" do
    not_if "rpm -q nginx-release-centos-7-0.el7.ngx.noarch"
  end
end

# Nginxインストール
package "nginx" do
  action :install
end

# Nginxの自動起動をOnにして起動
service "nginx" do
  action [:enable, :start]
end

# HTMLを配置
file '/usr/share/nginx/html/hello_itamae.html' do
  owner 'root'
  group 'root'
  mode  '755'
  content '<h1>Hello Itamae!!!</h1>'
end

