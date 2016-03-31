execute 'curl -L http://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh' do
  not_if "rpm -qa|grep -qw 'td-agent-2'"
end

execute "td-agent-gem install fluent-plugin-zabbix fluent-plugin-cloudwatch" do
  not_if "test `td-agent-gem list |grep -qw fluent-plugin-zabbix;echo $?` -eq 0 -a `td-agent-gem list |grep -qw fluent-plugin-cloudwatch;echo $?` -eq 0"
end

template "/etc/td-agent/td-agent.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    aws_access_key_id_1: secret["aws_access_key_id_1"],
    aws_secret_access_key_1: secret["aws_secret_access_key_1"],
    dbii_1: secret["dbii_1"],
    instanceid_1: secret["instanceid_1"],
    instanceid_1_1: secret["instanceid_1_1"]
  )
  notifies :restart, "service[td-agent]"
end

service 'td-agent' do
  action [:start, :enable]
end
