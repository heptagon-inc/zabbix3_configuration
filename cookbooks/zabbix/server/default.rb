node.reverse_merge!({
  zabbix: {
    server: {
      process: {
        StartPollers: 10,
        StartIPMIPollers: 0,
        StartPollersUnreachable: 1,
        StartTrappers: 1,
        StartPingers: 5,
        StartDiscoverers: 5,
        StartHTTPPollers: 5,
        StartTimers: 1,
        StartEscalators: 1,
        StartProxyPollers: 1,
        ProxyConfigFrequency: 60,
        ProxyDataFrequency: 1
      },
      cache: {
        HousekeepingFrequency: 1,
        MaxHousekeeperDelete: 5000,
        SenderFrequency: 30,
        CacheSize: '128M',
        CacheUpdateFrequency: 60,
        StartDBSyncers: 4,
        HistoryCacheSize: '256M',
        HistoryIndexCacheSize: '16M',
        TrendCacheSize: '256M',
        ValueCacheSize: '128M'
      },
      Timeout: 30,
      UnreachablePeriod: 60,
      LogSlowQueries: 3000,
      allow_root: 0
    }
  }
})

require_relative '../../../itamae_helper.rb'

%w(zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese).each {|pkg| package pkg}

template '/etc/zabbix/zabbix_server.conf' do
  owner 'root'
  group 'zabbix'
  mode '0640'
  variables(
    zabbix_server_db_host: secret["zabbix_server_db_host"],
    zabbix_server_db_database: secret["zabbix_server_db_database"],
    zabbix_server_db_user: secret["zabbix_server_db_user"],
    zabbix_server_db_password: secret["zabbix_server_db_password"],
    zabbix_server_db_port: secret['zabbix_server_db_port']
  )
end

# 初期テーブル作成をどうしようか...

%w(/usr/lib/zabbix/alertscripts/twilio.sh /usr/lib/zabbix/alertscripts/slack.rb /usr/lib/zabbix/alertscripts/chatwork.sh /usr/lib/zabbix/externalscripts/check_ssl.rb).each do |file|
  template file do
    owner 'zabbix'
    group 'zabbix'
    mode '0750'
    variables(
      chatwork_apikey: secret["chatwork_apikey"],
      chatwork_roomid: secret["chatwork_roomid"],
      twilio_sid: secret["twilio_sid"],
      twilio_token: secret["twilio_token"],
      twilio_from: secret["twilio_from"],
      twilio_to: secret["twilio_to"],
      slack_webhook: secret["slack_webhook"]
    )
  end
end

template '/var/www/html/call.xml' do
  owner 'nginx'
  group 'nginx'
  mode '0644'
end

service 'zabbix-server' do
  action [:start, :enable]
end
