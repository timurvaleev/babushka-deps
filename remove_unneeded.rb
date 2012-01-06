meta :remove do
  template {
    met? { which(basename) }
    meet { log_shell "Removing #{basename}", "apt-get -q -y remove --purge #{basename}", :sudo => true }
  }
end

dep 'portmap.remove'
