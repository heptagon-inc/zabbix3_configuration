%w(gcc gcc-c++ ruby23 ruby23-devel ruby23-irb ruby23-libs rubygems23 rubygems23-devel rubygem23-bigdecimal rubygem23-io-console rubygem23-json rubygem23-power_assert rubygem23-psych rubygem23-rdoc).each do |pkg|
  package pkg
end

execute 'alternatives --set ruby /usr/bin/ruby2.3' do
  not_if "test `alternatives --display ruby |grep -w 'link currently points to' | awk -F'/' '{print $4}'` == 'ruby2.3'"
end

%w(bundler slack-notifier).each do |pkg|
  gem_package pkg
end
