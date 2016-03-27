template '/etc/sysctl.d/10-custom.conf' unless check_container 'lxc'

execute 'sysctl -e -p' do
  subscribes :run, "template[/etc/sysctl.d/10-custom.conf]"
  action :nothing
end
