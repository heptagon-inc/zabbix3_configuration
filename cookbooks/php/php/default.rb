node.reverse_merge!({
  php: {
    php: {
      packages: [
        'php','php-cli','php-common','php-devel','php-fpm','php-gd','php-mbstring','php-mcrypt',
        'php-mysqlnd','php-pdo','php-pear','php-pecl-jsonc','php-pecl-jsonc-devel',
        'php-pecl-memcache','php-pecl-zip','php-process','php-xml','php-opcache'
      ],
      user: 'apache',
      fpm: {
        status: true,
        listen: '127.0.0.1:9000',
        pm_max_children: 32,
        pm_start_servers: 8,
        pm_min_spare_servers: 8,
        pm_max_spare_servers: 16
      }
    }
  }
})

node[:php][:php][:packages].each do |pkg|
  package pkg do
    action :install
  end
end

execute "sed -i \"s|.*date.timezone =|date.timezone = Asia/Tokyo|g\" /etc/php.ini" do
  not_if "grep -q -w \"^date.timezone = Asia/Tokyo\" /etc/php.ini"
end

template "/etc/php.d/00-custom.ini" do
  notifies :restart, "service[php-fpm-5.6]"
end

execute "chown -R #{node[:php][:php][:user]}: /var/lib/php/5.6/session/" do
  only_if "test `stat -c %U /var/lib/php/5.6/session` != '#{node[:php][:php][:user]}'"
end

if node[:php][:php][:fpm][:status]
  %w(/etc/php-fpm.conf /etc/php-fpm.d/www.conf).each do |f|
    template f do
      notifies :restart, "service[php-fpm-5.6]"
    end
  end

  service 'php-fpm-5.6' do
    action [:start, :enable]
  end
end
