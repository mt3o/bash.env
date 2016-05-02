# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac




# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


function _ssh_history_hosts()
{

local SSHHISTORY;
SSHHISTORY=`history |grep -o  'ssh [a-z][a-z0-9@.-]\{5,99\}' | sort | uniq | sed 's/\(ssh \)//'`;

local curr_arg;

  curr_arg=${COMP_WORDS[COMP_CWORD]}

  COMPREPLY=( $(compgen -W '$SSHHISTORY' -- $curr_arg ) );
}


complete -F _ssh_history_hosts ssh






CLASSPATH=$CLASSPATH:/usr/share/java/mysql.jar
export CLASSPATH



export XZ_OPT=-7e



#if [ -f ~/.bash__history ]; then
#    . ~/.bash__history
#fi



#if [ -f ~/.bash_prompt ]; then
#    . ~/.bash_prompt
#fi




#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


#if [ -f ~/.bash_completion_local ]; then
    #. ~/.bash_completion_local
#fi



CLASSPATH=$CLASSPATH:/usr/share/java/mysql.jar
export CLASSPATH






plugins="autojump completion history"

# Choose a Bash.env theme
theme=default

# Set my home host.
# So that when we login to a remote box our theme can change
# to the remote version with special colors, etc
dot_env_home_host='ubuntu-a3w'

# Set this to zero to avoid the verbosity on starting a new shell instance
dot_env_verbose=1

# Source the Bash.env environment
[[ -r "$HOME/.env/bash.env.sh" ]] && . "$HOME/.env/bash.env.sh"



#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
