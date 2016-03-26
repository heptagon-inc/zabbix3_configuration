template '/etc/sysctl.d/10-custom.conf'

execute 'sysctl -e -p' do
  subscribes :run, "template[/etc/sysctl.d/10-custom.conf]"
  action :nothing
end
