meta :remove do
  accepts_list_for :executable
  template {
    met? { which(executable).blank? }
    meet { log_shell "Removing #{basename}", "apt-get -q -y remove --purge #{basename}", :sudo => true }
    after {
      log_shell "Autoremoving packages", "apt-get -y autoremove", :sudo => true
    }
  }
end

dep 'portmap.remove' do
  executable '/sbin/portmap'
end

dep 'rsyslog.remove' do
  executable '/usr/sbin/rsyslogd'
end

dep 'apache2*.remove' do
  executable '/usr/sbin/apache2'
end

dep 'bind9.remove' do
  executable '/usr/sbin/named'
end

dep 'samba*.remove' do
  executable '/usr/sbin/smbd'
end

dep 'nscd.remove' do
  executable '/usr/sbin/nscd'
end

dep 'sendmail*.remove' do
  executable '/usr/lib/sm.bin/smtpd'
  before { log_shell 'Stopping sendmail', "invoke-rc.d sendmail stop", :sudo => true }
end

