package 'nginx' do
  options "--disablerepo=amzn-main"
end

link "/var/www/html/zabbix" do
  to "/usr/share/zabbix"
end

template "/etc/nginx/nginx.conf" do
  notifies :restart, "service[nginx]"
end

template "/etc/nginx/conf.d/zabbix.conf" do
  notifies :restart, "service[nginx]"
end

execute "chown -R nginx: /etc/zabbix/web" do
  only_if "test `stat -c %U /etc/zabbix/web` != 'nginx'"
end

service 'nginx' do
  action [:start, :enable]
end
