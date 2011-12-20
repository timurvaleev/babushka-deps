dep 'remove portmap' do
  met? { `which /sbin/portmap 2>&1`.include?('/sbin/portmap') }
  meet { sudo `apt-get -q -y remove --purge portmap` }
end
