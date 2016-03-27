execute "Create swap file." do
  only_if "test `cat /proc/swaps | grep -v 'Filename' | wc -l` -eq 0"
  user 'root'
  command "
    disksize=`df -m | grep -w 'xvda1' | awk '{print $2}'`
    if [ ${disksize} -gt 10240 ]; then
      fallocate -l 4194304k /swapfile1
      chmod 600 /swapfile1
      mkswap /swapfile1
      swapon /swapfile1
    else
      fallocate -l 2097152k /swapfile1
      chmod 600 /swapfile1
      mkswap /swapfile1
      swapon /swapfile1
    fi
  "
end

execute "echo -e '/swapfile1\tswap\tswap\tdefaults\t0 0' >> /etc/fstab" do
  not_if "grep -q -w swapfile1 /etc/fstab"
  user 'root'
end
