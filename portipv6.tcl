package require http

set com "!port6"
set com2 ".port6"

bind pub -|- $com ipv6_portcheck
bind pub -|- $com2 ipv6_portcheck

proc ipv6_portcheck {nick uhost hand chan arg} {
  global com com2
  set ipv6 [lindex $arg 0]
  set port6 [lindex $arg 1]
  if {$ipv6 == "" || $port6 == ""} {
    putquick "NOTICE $nick :Usage: $com <host> <port>"
  }
  if {$port6 != "" && $ipv6 != ""} {
    ::http::config -useragent "Mozilla/5.0"
    set http_req [::http::geturl http://www.ipv6tech.ch/index.shtml?tcpportscan=&hostname=$ipv6&vonport=$port6&bisport=$port6&checkbox=checkbox&submit_scan=Start+Portscan -timeout 2000]
    set data [::http::data $http_req]
    ::http::cleanup $http_req
    set port ""; set protokol ""; set statuz ""
    if {[regexp {<table><tr><td><font color=red>TCP6 Port (.*?) </font></td><td><font color=red><b>(.*?) </b></font></td><td><font color=red>(.*?) </font></td></tr>} $data "" port protokol statuz]} {
      set portz [lindex $port 0]
      set protokolz [lindex $protokol 0]
      if {$protokolz != ""} { set outdance "$portz - $protokolz" }
      if {$protokolz == ""} { set outdance "$portz" }
      puthelp "PRIVMSG $chan :Connection to \00312$ipv6\003 \(\00304$outdance\003\) is $statuz."
      } else {
      puthelp "PRIVMSG $chan :Connection to \00312$ipv6\003 \(\00304$port6\003\) was refused."
    }
  }
}
