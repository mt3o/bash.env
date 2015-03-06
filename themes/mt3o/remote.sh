local user_host=''
local current_dir=`fgc 075`'\w'$NOC
local ruby_prompt=`fgc 009`'‹$(ps1_ruby)›'$NOC
local git_prompt=`fgc 208`'$(ps1_git_status)'`fgc 191`' $(ps1_git_branch)'$NOC
local pc=''

local ip=`dig +short myip.opendns.com @resolver1.opendns.com`


# add a fix for Solaris' backward id command
id=`id |cut -f1 -d' '|sed -e 's/(.*$//'|cut -f2 -d'='`

if [ "$id" -eq 0 ]; then
  # We are root
  user_host=`fgc 196`'\u'`fgc 11`'@'`fgc 27`'\H'$NOC
  pc=`fgc 196`➤$NOC
else
  user_host=`fgc 238`'\u'`fgc 11`'@'`fgc 27`'\H'$NOC
  pc=➤$NOC
fi

#PS1="${user_host} ${current_dir} ${ruby_prompt} ${git_prompt}
#${pc} "$NOC

LastCommandIfFalse='$([[ $? != 0 ]] && echo "'$BRed'\342\234\227")'$Color_Off
LastCommandIfTrue='$([[ $? != 0 ]]  && echo "'$BGreen'\342\234\223")'$Color_Off

export PROMPT_COMMAND='\
  history -a;\
  history -r; \
  echo -en "\n\033[m\033[38;5;2m"\
    $(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))\
    "\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\
    \t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"\
    "\t\033[0;93m"'$ip'
  '


export PS1='\n'$LastCommandIfFalse$LastCommandIfTrue' ''['$Time24h'] '$Color_Off'\
 '$UColor'\u@\H '$Color_Off':]${SSH_TTY} '$Green'+${SHLVL}'$Black' '$Color_Off'['$Cyan'\#'$Color_Off'] \j:\!\n\
'\
"$current_dir ${git_prompt} $UColor $(ps1_prompt_char)$Color_Off "

