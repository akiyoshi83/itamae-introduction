if node[:platform] == "centos"
  package "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" do
    not_if "rpm -q nginx-release-centos-7-0.el7.ngx.noarch"
  end
end

package "nginx" do
  action :install
end

service "nginx" do
  action [:enable, :start]
end

