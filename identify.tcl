#########################################################################
#
#  use to encrypting your bot nick password with private message command
#     by typing: /msg <botnick> botnick <newnick> <password>
#
#########################################################################

bind msg n botnick msg_botnick
bind raw - NOTICE notice_bot

bind evnt - init-server evnt:init_server
proc evnt:init_server {type} {
  global nick botnick nickpass basechan
  putquick "MODE $botnick +i-ws"
  if {$botnick == $nick && $nickpass != ""} {
    putserv "NickServ identify $nick $nickpass"
    putserv "JOIN $basechan"
  }
}

bind raw - "432" release_nickserv
proc release_nickserv {unick uhost hand args} {
  global botnick nick nickpass
  putserv "NickServ release $nick $nickpass"
}

bind raw - "433" ghost_nickserv
proc ghost_nickserv {unick uhost hand args} {
  global botnick nick nickpass
  putserv "NickServ ghost $nick $nickpass"
}

utimer 1 {user}

proc dezip {txt} { return [decrypt 64 [unzip $txt]] }

proc zip {txt} { return [encrypt 64 [unzip $txt]] }

proc unzip {txt} {
  set retval $txt
  regsub ~ $retval "" retval
  return $retval
}

proc user {} {
  global nick nickpass
  if {[validuser "user"]} {
    if {[getuser "user" XTRA "NICK"]!=""} {
      set nick [dezip [getuser "user" XTRA "NICK"]]
    }
    if {[getuser "user" XTRA "NICKPASS"]!=""} {
      set nickpass [dezip [getuser "user" XTRA "NICKPASS"]]
    }
    } else {
    adduser "user" ""
    chattr "user" "-hp"
    +host "user" "*!*@dal.net"
  }
}

proc notice_bot {from keyword arg} {
  global botnick
  set nick [lindex [split $from !] 0] ; set uhost [lindex [split $from !] 1]
  if {[string match "*.*" $nick]} {return 0} ; set chan ""
  if {[string match "#*" [lindex $arg 0]]} {
    set chan [lindex $arg 0] ; set rest [lrange $arg 1 end]
  } else {set rest $arg}
  if {$chan != ""} {append char1s "$chan $rest"} else {set char1s $rest}
  msg_bot $nick $uhost $uhost $char1s ; return 0
}

proc msg_botnick {unick uhost hand rest} {
  global botnick nick nickpass
  if {![matchattr $hand n]} {
    puthelp "NOTICE $unick : denied"
    return 0
  }
  set bnick [lindex $rest 0]
  set bpass [lindex $rest 1]
  if {$bnick == "" || $bpass == ""} {
    puthelp "NOTICE $unick :\00304 usage: botnick <nick> <identify>"
    return 0
  }
  setuser "user" XTRA "NICK" [zip $bnick]
  setuser "user" XTRA "NICKPASS" [zip $bpass]
  set nick $bnick
  set nickpass $bpass
  puthelp "NOTICE $unick : \002NEW\002 Botnick\002 $bnick \002"
}
