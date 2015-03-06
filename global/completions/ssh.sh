#!/bin/bash

function _ssh_history_hosts()
{

local SSHHISTORY;
SSHHISTORY=`history |grep -o  'ssh [a-z][a-z0-9@.-]\{5,99\}' | sort | uniq | sed 's/\(ssh \)//'`;

local curr_arg;

  curr_arg=${COMP_WORDS[COMP_CWORD]}

  COMPREPLY=( $(compgen -W '$SSHHISTORY' -- $curr_arg ) );
}


complete -F _ssh_history_hosts ssh

