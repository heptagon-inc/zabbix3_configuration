include_cookbook 'zabbix/agent'

require_relative '../../../itamae_helper.rb'

%w(mysql56 mysql56-devel).each do |pkg|
  package pkg
end

template '/var/lib/zabbix/.my.cnf' do
  owner 'zabbix'
  group 'zabbix'
  mode '0640'
  notifies :restart, "service[zabbix-agent]"
  variables(
    variable_mysql_user_name: secret["mysql_user_name"],
    variable_mysql_user_pass: secret["mysql_user_pass"],
    variable_mysql_host: secret["mysql_host"]
  )
end
