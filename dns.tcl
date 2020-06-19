#----------------------------------------------------------------#
# DNS TCL version 2013                    Recoded by : Kien Sing #
#                                                                #
# Commands:                                                      #
#     !dns <IP/Hostname>                                         #
#----------------------------------------------------------------#

# CHARACTER SETTING : (Default)
set dnshost(cmdchar) "!"
set dnshost(cmdchar2) "."

#-------  ---- DO NOT CHANGE ANYTHING OF THIS LINES -----------  #
bind pub - [string trim $dnshost(cmdchar)]dns dns:res
bind pub - [string trim $dnshost(cmdchar2)]dns dns:res
bind pub - [string trim $dnshost(cmdchar)]address pub:host
bind pub - [string trim $dnshost(cmdchar2)]address pub:host
bind pub - [string trim $dnshost(cmdchar)]version pub:ver
bind pub - [string trim $dnshost(cmdchar2)]version pub:ver
bind pub - [string trim $dnshost(cmdchar)]check dns:nick
bind pub - [string trim $dnshost(cmdchar2)]check dns:nick
bind raw * 311 raw:host
bind raw * 401 raw:fail

set dns_chan ""
set dns_host ""
set dns_nick ""
set dns_bynick ""

proc pub:host {nick uhost hand chan arg} {
  global dns_chan
  set dns_chan "$chan"
  putserv "WHOIS [lindex $arg 0]"
}

proc raw:host {from signal arg} {
  global dns_chan dns_nick dns_host dns_bynick
  set dns_nick "[lindex $arg 1]"
  set dns_host "*![lindex $arg 2]@[lindex $arg 3]"
  foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :\00304\002$dns_nick\002\003 has address \00302$dns_host\003" }
  if {$dns_bynick == "oui"} {
    set hostip [split [lindex $arg 3] ]
    dnslookup $hostip resolve_rep $dns_chan $hostip
    set dns_bynick "non"
    set out [exec host $hostip]
    set lines [split $out \n]
    foreach line $lines {
      if {[regexp {(.*) has address (.*)} $line match rHost output]} {
        putnow "PRIVMSG $dns_chan :Named address: \00306\037$hostip\037\003 - Resolved to: \00302\037$output\037\003"
        } elseif {[regexp {(.*) has IPv6 address (.*)} $line match rHost output]} {
        putnow "PRIVMSG $dns_chan :Named address: \00306\037$hostip\037\003 -\(\00303IPv6\003\)- Resolved to: \00302\037$output\037\003"
        } elseif {[regexp {(.*) mail is handled by (.*) (.*)} $line match rHost pri output]} {
        putnow "PRIVMSG $dns_chan :\00306\037$hostip\037\003 mail is handled by \(\002$pri\002\) \00303$output\003"
        } elseif {[regexp {(.*) name server (.*)} $line match rHost output]} {
        putnow "PRIVMSG $dns_chan :\00306\037$hostip\037\003 has NS => $output"
        } elseif {[regexp {(.*) domain name pointer (.*)} $line match rHost output]} {
        putnow "PRIVMSG $dns_chan :Named address: \00306\037$hostip\037\003 - Resolved to: \00302\037$output\037\003"
        putnow "PRIVMSG $dns_chan :\00304$line\003"
      }
    }
    return 0
  }
}

proc raw:fail {from signal arg} {
  global dns_chan
  set arg "[lindex $arg 1]"
  foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :Nickname \002\00304$arg\002\003 is not \00303ONLINE\003." }
}

proc pub:ver {nick uhost hand chan text} {
  putserv "PRIVMSG $chan :\00304\002D\00303N\00306S\002 \00312\002v\002\0030520.13\003"
}

proc dns:res {nick uhost hand chan text} {
  if {$text == ""} {
    puthelp "PRIVMSG $chan :\002\037C\002\037ommand\002\037\:\002\037 [string trim $dnshost(cmdchar)]dns <Hostname\/IP>"
    } else {
    set hostip [split $text]
    dnslookup $hostip resolve_rep $chan $hostip
    set out [exec host $hostip]
    set lines [split $out \n]
    foreach line $lines {
      if {[regexp {(.*) has address (.*)} $line match rHost output]} {
        putnow "PRIVMSG $chan :Named address: \00306\037$hostip\037\003 - Resolved to: \00302\037$output\037\003"
        } elseif {[regexp {(.*) has IPv6 address (.*)} $line match rHost output]} {
        putnow "PRIVMSG $chan :Named address: \00306\037$hostip\037\003 -\(\00303IPv6\003\)- Resolved to: \00302\037$output\037\003"
        } elseif {[regexp {(.*) mail is handled by (.*) (.*)} $line match rHost pri output]} {
        putnow "PRIVMSG $chan :\00306\037$hostip\037\003 mail is handled by \(\002$pri\002\) \00303$output\003"
        } elseif {[regexp {(.*) name server (.*)} $line match rHost output]} {
        putnow "PRIVMSG $chan :\00306\037$hostip\037\003 has NS => $output"
        } elseif {[regexp {(.*) domain name pointer (.*)} $line match rHost output]} {
        putnow "PRIVMSG $chan :Named address: \00306\037$hostip\037\003 - Resolved to: \00302\037$output\037\003"
        putnow "PRIVMSG $chan :\00304$line\003"
      }
    }
    return 0
  }
}

proc dns:nick {nick uhost hand chan arg} {
  global dns_chan dns_bynick dnshost
  if {$arg == ""} {
    puthelp "PRIVMSG $chan :\002\037C\002\037ommand\002\037:\002\037 [string trim $dnshost(cmdchar)]check <Nickname>"
    } else {
    set dns_chan "$chan"
    set dns_bynick "oui"
    putserv "WHOIS [lindex $arg 0]"
  }
  return 0
}

proc resolve_rep {ip host status chan hostip} {
  if {!$status} {
    puthelp "PRIVMSG $chan :\(\00312IPv4\003\) Unable to resolve address\: \00302\037$hostip\037\003"
  }
  return 0
}

putlog "..:::::::::::::::::::::::::::::::::::::::::::::::::::.."
putlog "..::         DNS TCL Successfully Loaded!!         ::.."
putlog "..:::::::::::::::::::::::::::::::::::::::::::::::::::.."
