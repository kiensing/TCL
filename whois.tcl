###############################################################################
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ #
# ¤                      ___        »            † Whois Nick †             ¤ #
# ¤                     /\_ \       »                  TCL                  ¤ #
# ¤   ___    ___     __ \//\ \      »            Copyright © 2009           ¤ #
# ¤  / __/  / __`\  / __`\\ \ \     »                                       ¤ #
# ¤ /\ \__/\\ \L\ \/\ \L\  \_\ \_   »       Chemarank - Creative TeaM       ¤ #
# ¤ \ \____/ \____/\ \____//\____\  »          Kien Sing - RAYMAN           ¤ #
# ¤  \/___/ \/___/  \/___/ \/____/  »        #Tao @ DALnet Servers          ¤ #
# ¤                                 »                                       ¤ #
# ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ #
###############################################################################

# Please don't be lame and rip my script. I've made it for Quakenet but i assume if the ircd you want
# to use it on has the same RAW's you can use it just fine.
set whois(author) "RAYMAN on DALnet"
# Version History
# 0.1      - Made a start, first expermimental test.
# 0.2-0.5  - Finished some more code
# 0.6-0.8  - The script was fully functional
# 0.9      - Removed some silly crap that didnt work for Quakenet anyhow (shows which server he was on)
# 1.0      - Cleaned some of the code, and it works fine on Quakenet, It
#            also shows idle time and signon time now.
set whois(version) "20.13"
# What is the minimum access someone needs to perform a whois with the bot?
# o = global op, m = global master, n = global owner
# |o = channel op, |m = channel master, |n = channel owner
set whois(acc) ""

bind pub $whois(acc) ".whois" whois:nick

set fucktime 0
proc whois:nick {nickname hostname handle channel arguments} {
  global whois fucktime
  set target [lindex [split $arguments] 0]
  if {$target == ""} {
    putquick "PRIVMSG $channel :Using: .whois <nick>"
    return 0
  }
  set replytime [unixtime]
  if {$replytime - $fucktime  > 15} {
    putquick "WHOIS $target $target"
    putquick "PRIVMSG $channel :\[ Whois result for \: \002\00303$target\003\002 \]"
    set ::whoischannel $channel
    set ::whoistarget $target
    bind RAW - 402 whois:nosuch
    bind RAW - 311 whois:info
    bind RAW - 319 whois:channels
    bind RAW - 312 whois:servrun
    bind RAW - 307 whois:identnick
    bind RAW - 301 whois:away
    bind RAW - 313 whois:ircop
    bind RAW - 330 whois:auth
    bind RAW - 310 whois:extra
    bind RAW - 317 whois:idle
    bind RAW - 275 whois:ssl
    bind RAW - 318 whois:end
    set fucktime $replytime
  }
}
proc whois:putmsg {channel arguments} {
  putquick "PRIVMSG $channel :$arguments"
  return 0
}
proc whois:nosuch {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  whois:putmsg $channel "Sorry, but.. \002\00303$target\002\003 is not \00302ONLINE\003"
  unbind RAW - 402 whois:nosuch
}
proc whois:info {from keyword arguments} {
  set channel $::whoischannel
  set nickname [lindex [split $arguments] 1]
  set ident [lindex [split $arguments] 2]
  set host [lindex [split $arguments] 3]
  set realname [string range [join [lrange $arguments 5 end]] 1 end]
  whois:putmsg $channel "$nickname is $ident@$host * $realname"
  unbind RAW - 311 whois:info
}
proc whois:ircop {from keyword arguments} {
  set channel $::whoischannel
  set ircops [string range [join [lrange $arguments 2 end]] 1 end]
  set target $::whoistarget
  whois:putmsg $channel "$target $ircops"
  unbind RAW - 313 whois:ircop
}
proc whois:away {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  set awaymessage [string range [join [lrange $arguments 2 end]] 1 end]
  whois:putmsg $channel "$target is away: $awaymessage"
  unbind RAW - 301 whois:away
}
proc whois:channels {from keyword arguments} {
  set channel $::whoischannel
  set channels [string range [join [lrange $arguments 2 end]] 1 end]
  set target $::whoistarget
  whois:putmsg $channel "$target on $channels"
  unbind RAW - 319 whois:channels
}
proc whois:servrun {from keyword arguments} {
  set channel $::whoischannel
  set servinfo [lindex [split $arguments] 2]
  set servrun [string range [join [lrange $arguments 3 end]] 1 end]
  set target $::whoistarget
  whois:putmsg $channel "$target is using $servinfo $servrun"
  unbind RAW - 312 whois:servrun
}
proc whois:identnick {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  whois:putmsg $channel "$target has identified for this nick"
  unbind RAW - 307 whois:identnick
}
proc whois:auth {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  set authname [lindex [split $arguments] 2]
  whois:putmsg $channel "$target is authed as $authname"
  unbind RAW - 330 whois:auth
}
proc whois:idle {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  set idletime [lindex [split $arguments] 2]
  set signon [lindex [split $arguments] 3]
  whois:putmsg $channel "$target has been idle for [duration $idletime]. signon time [ctime $signon]"
  unbind RAW - 317 whois:idle
}
proc whois:extra {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  set extra2 [string range [join [lrange $arguments 2 end]] 1 end]
  whois:putmsg $channel "$target $extra2"
  unbind RAW - 310 whois:extra
}
proc whois:ssl {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  whois:putmsg $channel "$target is using a secure connection (SSL)"
  unbind RAW - 275 whois:ssl
}
proc whois:end {from keyword arguments} {
  set channel $::whoischannel
  set target $::whoistarget
  whois:putmsg $channel "$target End of /WHOIS list."
  unbind RAW - 318 whois:end
}

putlog "Public whois script $whois(version) by $whois(author)"