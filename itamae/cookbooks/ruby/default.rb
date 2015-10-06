package 'ruby'
package 'ruby-devel'

file "/etc/profile.d/.gemrc" do
  owner "root"
  group "root"
  mode  "644"
  content "gem: --no-ri --no-rdoc"
end

execute 'gem install bundler' do
  not_if 'gem list | grep bundler'
end

