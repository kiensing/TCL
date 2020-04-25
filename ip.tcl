##############################
# SETTINGS
##############################

# version
set whoisinfo(version) "1.0"
# trigger
set whoisinfo(trigger) ".ip"
set whoisinfo(trigger2) "!ip"
# whois port
set whoisinfo(port) 43
# ripe server
set whoisinfo(ripe) "whois.ripe.net"
# arin server
set whoisinfo(arin) "whois.arin.net"
# apnic server
set whoisinfo(apnic) "whois.apnic.net"
# lacnic server
set whoisinfo(lacnic) "whois.lacnic.net"
# afrinic server
set whoisinfo(afrinic) "whois.afrinic.net"

##############################
# BINDS
##############################

bind pub - $whoisinfo(trigger) pub_whoisinfo
bind pub - $whoisinfo(trigger2) pub_whoisinfo

##############################
# CODE
##############################

set codes {
  "BIZ=Business"
  "COM=US Commercial"
  "EDU=US Educational"
  "GOV=US Government"
  "INT=International"
  "MIL=US Military"
  "NET=Network"
  "ORG=Non-Profit Organization"
  "ARPA=Old style Arpanet"
  "NATO=Nato field"
  "AD=Andorra"
  "AE=United Arab Emirates"
  "AF=Afghanistan"
  "AG=Antigua and Barbuda"
  "AI=Anguilla"
  "AL=Albania"
  "AM=Armenia"
  "AN=Netherlands Antilles"
  "AO=Angola"
  "AQ=Antarctica"
  "AR=Argentina"
  "AS=American Samoa"
  "AT=Austria"
  "AU=Australia"
  "AW=Aruba"
  "AZ=Azerbaijan"
  "BA=Bosnia and Herzegovina"
  "BB=Barbados"
  "BD=Bangladesh"
  "BE=Belgium"
  "BF=Burkina Faso"
  "BG=Bulgaria"
  "BH=Bahrain"
  "BI=Burundi"
  "BJ=Benin"
  "BM=Bermuda"
  "BN=Brunei Darussalam"
  "BO=Bolivia"
  "BR=Brazil"
  "BS=Bahamas"
  "BT=Bhutan"
  "BV=Bouvet Island"
  "BW=Botswana"
  "BY=Belarus"
  "BZ=Belize"
  "CA=Canada"
  "CC=Cocos Islands"
  "CF=Central African Republic"
  "CG=Congo"
  "CH=Switzerland"
  "CI=Cote D'Ivoire"
  "CK=Cook Islands"
  "CL=Chile"
  "CM=Cameroon"
  "CN=China"
  "CO=Colombia"
  "CR=Costa Rica"
  "CS=Former Czechoslovakia"
  "CU=Cuba"
  "CV=Cape Verde"
  "CX=Christmas Island"
  "CY=Cyprus"
  "CZ=Czech Republic"
  "DE=Germany"
  "DJ=Djibouti"
  "DK=Denmark"
  "DM=Dominica"
  "DO=Dominican Republic"
  "DZ=Algeria"
  "EC=Ecuador"
  "EE=Estonia"
  "EG=Egypt"
  "EH=Western Sahara"
  "ER=Eritrea"
  "ES=Spain"
  "ET=Ethiopia"
  "FI=Finland"
  "FJ=Fiji"
  "FK=Falkland Islands"
  "FM=Micronesia"
  "FO=Faroe Islands"
  "FR=France"
  "FX=France, Metropolitan"
  "GA=Gabon"
  "GB=Great Britain"
  "GD=Grenada"
  "GE=Georgia"
  "GF=French Guiana"
  "GH=Ghana"
  "GI=Gibraltar"
  "GL=Greenland"
  "GM=Gambia"
  "GN=Guinea"
  "GP=Guadeloupe"
  "GQ=Equatorial Guinea"
  "GR=Greece"
  "GS=S. Georgia and S. Sandwich Isls."
  "GT=Guatemala"
  "GU=Guam"
  "GW=Guinea-Bissau"
  "GY=Guyana"
  "HK=Hong Kong"
  "HM=Heard and McDonald Islands"
  "HN=Honduras"
  "HR=Croatia"
  "HT=Haiti"
  "HU=Hungary"
  "ID=Indonesia"
  "IE=Ireland"
  "IL=Israel"
  "IN=India"
  "IO=British Indian Ocean Territory"
  "IQ=Iraq"
  "IR=Iran"
  "IS=Iceland"
  "IT=Italy"
  "JM=Jamaica"
  "JO=Jordan"
  "JP=Japan"
  "KE=Kenya"
  "KG=Kyrgyzstan"
  "KH=Cambodia"
  "KI=Kiribati"
  "KM=Comoros"
  "KN=Saint Kitts and Nevis"
  "KP=North Korea"
  "KR=South Korea"
  "KW=Kuwait"
  "KY=Cayman Islands"
  "KZ=Kazakhstan"
  "LA=Laos"
  "LB=Lebanon"
  "LC=Saint Lucia"
  "LI=Liechtenstein"
  "LK=Sri Lanka"
  "LR=Liberia"
  "LS=Lesotho"
  "LT=Lithuania"
  "LU=Luxembourg"
  "LV=Latvia"
  "LY=Libya"
  "MA=Morocco"
  "MC=Monaco"
  "MD=Moldova"
  "MG=Madagascar"
  "MH=Marshall Islands"
  "MK=Macedonia"
  "ML=Mali"
  "MM=Myanmar"
  "MN=Mongolia"
  "MO=Macau"
  "MP=Northern Mariana Islands"
  "MQ=Martinique"
  "MR=Mauritania"
  "MS=Montserrat"
  "MT=Malta"
  "MU=Mauritius"
  "MV=Maldives"
  "MW=Malawi"
  "MX=Mexico"
  "MY=Malaysia"
  "MZ=Mozambique"
  "NA=Namibia"
  "NC=New Caledonia"
  "NE=Niger"
  "NF=Norfolk Island"
  "NG=Nigeria"
  "NI=Nicaragua"
  "NL=Netherlands"
  "NO=Norway"
  "NP=Nepal"
  "NR=Nauru"
  "NT=Neutral Zone"
  "NU=Niue"
  "NZ=New Zealand"
  "OM=Oman"
  "PA=Panama"
  "PE=Peru"
  "PF=French Polynesia"
  "PG=Papua New Guinea"
  "PH=Philippines"
  "PK=Pakistan"
  "PL=Poland"
  "PM=St. Pierre and Miquelon"
  "PN=Pitcairn"
  "PR=Puerto Rico"
  "PS=Palestinian State"
  "PT=Portugal"
  "PW=Palau"
  "PY=Paraguay"
  "QA=Qatar"
  "RE=Reunion"
  "RO=Romania"
  "RU=Russian Federation"
  "RW=Rwanda"
  "SA=Saudi Arabia"
  "Sb=Solomon Islands"
  "SC=Seychelles"
  "SD=Sudan"
  "SE=Sweden"
  "SG=Singapore"
  "SH=St. Helena"
  "SI=Slovenia"
  "SJ=Svalbard and Jan Mayen Islands"
  "SK=Slovak Republic"
  "SL=Sierra Leone"
  "SM=San Marino"
  "SN=Senegal"
  "SO=Somalia"
  "SR=Suriname"
  "ST=Sao Tome and Principe"
  "SU=Former USSR"
  "SV=El Salvador"
  "SY=Syria"
  "SZ=Swaziland"
  "TC=Turks and Caicos Islands"
  "TD=Chad"
  "TF=French Southern Territories"
  "TG=Togo"
  "TH=Thailand"
  "TJ=Tajikistan"
  "TK=Tokelau"
  "TM=Turkmenistan"
  "TN=Tunisia"
  "TO=Tonga"
  "TP=East Timor"
  "TR=Turkey"
  "TT=Trinidad and Tobago"
  "TV=Tuvalu"
  "TW=Taiwan"
  "TZ=Tanzania"
  "UA=Ukraine"
  "UG=Uganda"
  "UK=United Kingdom"
  "UM=US Minor Outlying Islands"
  "US=United States"
  "UY=Uruguay"
  "UZ=Uzbekistan"
  "VA=Vatican City State"
  "VC=Saint Vincent and the Grenadines"
  "VE=Venezuela"
  "VG=Virgin Islands (British)"
  "VI=Virgin Islands (U.S.)"
  "VN=Viet Nam"
  "VU=Vanuatu"
  "WF=Wallis and Futuna Islands"
  "WS=Samoa"
  "YE=Yemen"
  "YT=Mayotte"
  "YU=Yugoslavia"
  "ZA=South Africa"
  "ZM=Zambia"
  "ZR=Zaire"
  "ZW=Zimbabwe"
}

set used 0

proc whoisinfo_setarray {} {
  global query
  set query(netname) "(none)"
  set query(country) "(none)"
  set query(orgname) "(none)"
  set query(orgid) "(none)"
  set query(range) "(none)"
}

proc whoisinfo_display {chan} {
  global query
  global codes used
  incr used
  set input $query(country)
  set len [string length $input]
  set results 0
  foreach code $codes {
    set splits [split $code "="]
    set code [lindex $splits 0]
    set value [lindex $splits 1]
    if {[string tolower $input]==[string tolower $code]} {
      set results 1
      set countryname $value
    }
  }
  if {$results==0} {
      set countryname "Unknown"
  }
  putlog "Firstline: $query(firstline)"
  puthelp "PRIVMSG $chan :\00301,0 \[\002Whois\002\00307 $query(orgid)\00301\]\002 R\002ange:\00302 $query(range) \00301- \002N\002etname:\00303 $query(netname) \00301- \002O\002rganisation:\00312 $query(orgname) \00301- \002C\002ountry:\00304\002 $query(country) \002\00301\($countryname\) \003"
}

proc pub_whoisinfo {nick uhost handle chan search} {
  global whoisinfo
  global query
  whoisinfo_setarray
  if {[whoisinfo_whois $whoisinfo(arin) $search]==1} {
    if {[string compare [string toupper $query(orgid)] "RIPE"]==0} {
      if {[whoisinfo_whois $whoisinfo(ripe) $search]==1} {
        whoisinfo_display $chan
      }
      } elseif {[string compare [string toupper $query(orgid)] "APNIC"]==0} {
      if {[whoisinfo_whois $whoisinfo(apnic) $search]==1} {
        whoisinfo_display $chan
      }
      } elseif {[string compare [string toupper $query(orgid)] "LACNIC"]==0} {
      if {[whoisinfo_whois $whoisinfo(lacnic) $search]==1} {
        whoisinfo_display $chan
      }
      } elseif {[string compare [string toupper $query(orgid)] "AFRINIC"]==0} {
      if {[whoisinfo_whois $whoisinfo(afrinic) $search]==1} {
        whoisinfo_display $chan
      }
      } else {
      whoisinfo_display $chan
    }
    } else {
    if { [info exist query(firstline)] } {
      puthelp "PRIVMSG $chan :\00301,0 \[\002Whois\002\00307 GLOBAL\00301\] $query(firstline) \003"
      } else {
      puthelp "PRIVMSG $chan :\00301,0 \[\002Whois\002\00307 GLOBAL\00301\] ERROR \003"
    }
  }
}

proc whoisinfo_whois {server search} {
  global whoisinfo
  global query
  set desccount 0
  set firstline 0
  set reply 0
  putlog "Whois: $server:$whoisinfo(port) -> $search"
  if {[catch {set sock [socket -async $server $whoisinfo(port)]} sockerr]} {
    puthelp "PRIVMSG $chan :\[\002Whois\002\] Error: $sockerr. Try again later."
    close $sock
    return 0
  }
  puts $sock $search
  flush $sock
  while {[gets $sock whoisline]>=0} {
    putlog "Whois: $whoisline"
    if {[string index $whoisline 0]!="#" && [string index $whoisline 0]!="%" && $firstline==0} {
      if {[string trim $whoisline]!=""} {
        set query(firstline) [string trim $whoisline]
        set firstline 1
      }
    }
    if {[regexp -nocase {netname:(.*)} $whoisline all item]} {
      set query(netname) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {owner-c:(.*)} $whoisline all item]} {
      set query(netname) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {country:(.*)} $whoisline all item]} {
      set query(country) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {descr:(.*)} $whoisline all item] && $desccount==0} {
      set query(orgname) [string trim $item]
      set desccount 1
      set reply 1
      } elseif {[regexp -nocase {orgname:(.*)} $whoisline all item]} {
      set query(orgname) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {owner:(.*)} $whoisline all item]} {
      set query(orgname) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {orgid:(.*)} $whoisline all item]} {
      set query(orgid) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {inetnum:(.*)} $whoisline all item]} {
      set query(range) [string trim $item]
      set reply 1
      } elseif {[regexp -nocase {netrange:(.*)} $whoisline all item]} {
      set query(range) [string trim $item]
      set reply 1
    }
  }
  close $sock
  return $reply
}


putlog "ip.tcl v$whoisinfo(version) loaded."
