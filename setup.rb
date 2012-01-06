#function remove_unneeded {
#    check_remove /sbin/portmap portmap
#
#    check_remove /usr/sbin/rsyslogd rsyslog
#
#    check_remove /usr/sbin/apache2 'apache2*'
#    check_remove /usr/sbin/named bind9
#    check_remove /usr/sbin/smbd 'samba*'
#    check_remove /usr/sbin/nscd nscd
#
#    if [ -f /usr/lib/sm.bin/smtpd ]
#    then
#        invoke-rc.d sendmail stop
#        check_remove /usr/lib/sm.bin/smtpd 'sendmail*'
#    fi
#}

#function check_remove {
#    if [ -n "`which "$1" 2>/dev/null`" ]
#    then
#        DEBIAN_FRONTEND=noninteractive apt-get -q -y remove --purge "$2"
#        print_info "$2 removed"
#    else
#        print_warn "$2 is not installed"
#    fi
#}
dep 'system update' do
  sudo("apt-get update")
  sudo("apt-get upgrade -y -q")
end

dep 'setup' do
  requires 'system update'
end
