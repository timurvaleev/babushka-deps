dep 'system update' do
  log_shell 'Update', "apt-get update", :sudo => true
  log_shell 'Upgrade', "apt-get upgrade", :sudo => true
end

dep 'dash.managed' do
  installs 'dash'
end

dep 'dropbear.managed' do
  installs 'dropbear'
  provides %w[dropbearkey]
end

dep 'xinetd.managed' do
  installs 'xinetd'
end

dep 'dash' do
  requires 'dash.managed'
  sudo("rm -f /bin/sh")
  sudo("ln -s dash /bin/sh")
end

dep 'sshd_not_to_be_run' do
  met? { !File.exists?('/etc/ssh/sshd_not_to_be_run') }
  meet { sudo("touch /etc/ssh/sshd_not_to_be_run") }
end

dep 'dropbear' do
  requires 'dropbear.managed'
  requires 'xinetd.managed'
  requires 'sshd_not_to_be_run'
  met? { !File.exists?('/etc/xinetd.d/dropbear') }
  meet {
    log_shell "Stopping ssh", "invoke-rc.d ssh stop", :sudo => true
    render_erb "xinetd/dropbear.erb", :to => '/etc/xinetd.d/dropbear', :sudo => true
    log_shell "Starting xinetd", "invoke-rc.d xinetd restart", :sudo => true
  }
end  

dep 'setup' do
  requires 'system update'
  requires 'portmap.remove'
  requires 'rsyslog.remove'
  requires 'apache2*.remove'
  requires 'bind9.remove'
  requires 'samba*.remove'
  requires 'nscd.remove'
  requires 'sendmail*.remove'
  requires 'dash'
  requires 'dropbear' 
end


