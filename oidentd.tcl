bind evnt - connect-server oidentd

proc oidentd {evnt} {
  global env username
  if {![file exists "$env(HOME)/.oidentd.conf"]} {
    set c_oidentd [open "$env(HOME)/.oidentd.conf" a+]
    close $c_oidentd
  }
  set a_oidentd [open $env(HOME)/.oidentd.conf w+]
  puts $a_oidentd "global \{ reply \"$username\" \}"
  close $a_oidentd
}
