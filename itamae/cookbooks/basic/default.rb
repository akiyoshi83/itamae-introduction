# プラグインでSELinuxを無効化
include_recipe 'selinux::disabled'

%w(
  vim-enhanced
  tree
).each do |name|
  package name do
    action :install
  end
end

