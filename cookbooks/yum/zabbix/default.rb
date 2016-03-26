if node[:platform] == "amazon"
  rpm_package_from_url 'http://youyo.github.io/yumrepo/zabbix/3.0/amzn1/noarch/zabbix-release-3.0-1.amzn1.noarch.rpm' do
    repo 'youyo-zabbix30-amzn1-base'
  end
end
