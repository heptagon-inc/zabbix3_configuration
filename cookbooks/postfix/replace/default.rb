package 'postfix'

service 'postfix' do
  action [:start,:enable]
end

execute 'alternatives --set mta /usr/sbin/sendmail.postfix' do
  not_if "test `alternatives --display mta |grep -w 'link currently points to' | awk -F'/' '{print $4}'` == 'sendmail.postfix'"
end

service 'sendmail' do
  action [:disable,:stop]
end

package 'sendmail' do
  action :remove
end
