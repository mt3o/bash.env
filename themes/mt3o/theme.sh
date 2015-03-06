#!/bin/bash

#PROMPT_COMMAND="echo -ne \"\033]0;${USER}@${HOSTNAME}\007\""



function the_theme {
  local thisdir=$(dirname $BASH_SOURCE)

  #echo "HOSTNAME is $HOSTNAME"
  #echo "dot_env_home_host is $dot_env_home_host"

  if [[ "$dot_env_home_host" == "$HOSTNAME" ]]; then
    . "${thisdir}/local.sh"
  else # We are on foreign soil

    . "${thisdir}/remote.sh"
  fi

export PS2='> '
export PS4='+ '
}

#echo "default theme";

the_theme
