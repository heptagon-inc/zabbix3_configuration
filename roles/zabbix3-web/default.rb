include_cookbook 'common-definitions'
include_role 'yum-repositories'
include_cookbook 'os/kernel-params'
include_cookbook 'os/swap'
include_cookbook 'os/update'
include_cookbook 'os/packages'
include_cookbook 'os/timezone'
include_cookbook 'os/history-time'
#include_cookbook 'os/user'
include_cookbook 'os/sshd'
include_cookbook 'zabbix/agent'
include_cookbook 'mysql/client'
include_cookbook 'php/php'
include_cookbook 'zabbix/server'
