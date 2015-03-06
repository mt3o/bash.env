# In here we use different color definitions, wrapped with literal \[ and \]
# This prevents horizontal scrolling problems for prompts
# Don't use these colors for terminal output.
# Instead use 'global_colors.sh'
# See 'os' or 'host' prompt.sh files for the actual prompt settings

BG_BLACK="\[\033[0;40m\]"
BG_RED="\[\033[0;41m\]"
BG_GREEN="\[\033[0;42m\]"
BG_BROWN="\[\033[0;43m\]"
BG_BLUE="\[\033[0;44m\]"
BG_MAGENTA="\[\033[0;45m\]"
BG_CYAN="\[\033[0;46m\]"
BG_LIGHT_GRAY="\[\033[0;47m\]"

BG_YELLOW='\e[43m'

BLACK="\[\033[0;30m\]"
DARK_GRAY="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
BROWN="\[\033[0;33m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
MAGENTA="\[\033[0;35m\]"
LIGHT_MAGENTA="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
NO_COLOR="\[\033[0m\]"
NOC=$NO_COLOR

Color_Off='\[\e[0m\]'       # Text Reset
Black='\[\e[0;30m\]'        # Black
Red='\[\e[0;31m\]'          # Red
Green='\[\e[0;32m\]'        # Green
Yellow='\[\e[0;33m\]'       # Yellow
Blue='\[\e[0;34m\]'         # Blue
Purple='\[\e[0;35m\]'       # Purple
Cyan='\[\e[0;36m\]'         # Cyan
White='\[\e[0;37m\]'        # White

# Bold
BBlack='\[\e[1;30m\]'       # Black
BRed='\[\e[1;31m\]'         # Red
BGreen='\[\e[1;32m\]'       # Green
BYellow='\[\e[1;33m\]'      # Yellow
BBlue='\[\e[1;34m\]'        # Blue
BPurple='\[\e[1;35m\]'      # Purple
BCyan='\[\e[1;36m\]'        # Cyan
BWhite='\[\e[1;37m\]'       # White


# High Intensity
IBlack='\[\e[0;90m\]'       # Black
IRed='\[\e[0;91m\]'         # Red
IGreen='\[\e[0;92m\]'       # Green
IYellow='\[\e[0;93m\]'      # Yellow
IBlue='\[\e[0;94m\]'        # Blue
IPurple='\[\e[0;95m\]'      # Purple
ICyan='\[\e[0;96m\]'        # Cyan
IWhite='\[\e[0;97m\]'       # White

# Bold High Intensity
BIBlack='\[\e[1;90m\]'      # Black
BIRed='\[\e[1;91m\]'        # Red
BIGreen='\[\e[1;92m\]'      # Green
BIYellow='\[\e[1;93m\]'     # Yellow
BIBlue='\[\e[1;94m\]'       # Blue
BIPurple='\[\e[1;95m\]'     # Purple
BICyan='\[\e[1;96m\]'       # Cyan
BIWhite='\[\e[1;97m\]'      # White

if [[ ${EUID} == 0 ]] ; then
   UColor=$BIRed
else
   UColor=$BIBlue
fi


Time24h='\t'
PathShort='\W'
PathLong='\w'

# Get 256 colors
fgc() { echo -ne "\[\033[38;5;$1m\]"; }
bgc() { echo -ne "\[\033[48;5;$1m\]"; }
clr() { echo -ne "$(fgc $1)$(bgc $2)"; }
noc() { echo -ne "\[\033[0m\]"; }
alias rst='noc'

# The following are from Wayne Sequin's RVM
# http://beginrescueend.com
ps1_titlebar() {
  case $TERM in
    (xterm*|rxvt*)
      printf "%s" "\033]0;\\u@\\h: \W\\007"
      ;;
  esac
}

ps1_git_branch() {
  local branch=""
  shopt -s extglob # Important, for our nice matchers :)
  command -v git >/dev/null 2>&1 || {
    printf "[git not found]"
    return 0
  }
  branch=$(git symbolic-ref -q HEAD 2>/dev/null) || return 0 # Not in git repo.
  branch=${branch##refs/heads/}
  printf ${branch}
}

ps1_sha() {
  local sha1=""
  shopt -s extglob # Turns on this "${branch:-"(no branch)"}" kind of string matcher
  command -v git >/dev/null 2>&1 || {
    printf "[git not found]"
    return 0
  }
  sha1=$(git rev-parse --short --quiet HEAD)
  printf ${sha1}
}

ps1_git_status() {
  local git_status="$(git status 2>/dev/null)"
  [[ "${git_status}" = *deleted* ]]                    && printf "%s" "-"
  [[ "${git_status}" = *Untracked[[:space:]]files:* ]] && printf "%s" "+"
  [[ "${git_status}" = *modified:* ]]                  && printf "%s" "*"
}

ps1_system_ruby() {
  local ruby_id=∫`echo $(ruby -v)|awk '{print $2}'`
  printf "%s" "${ruby_id}"
}

ps1_ruby() {
  local ruby_id="no-ruby"
  local gemset_id="no-gemset"
  type rvm-prompt >& /dev/null
  local use_rvm=$?
  type rbenv >& /dev/null
  local use_rbenv=$?

  if [[ "$use_rvm" == "0" ]]; then
    ruby_id="❥$(rvm-prompt)"
    if [[ "${ruby_id}" = "❥" ]]; then
      ps1_system_ruby
      return
    fi
  elif [[ "$use_rbenv" == "0" ]]; then
    ruby_id="▸$(rbenv version-name)"
  elif [[ -n `which ruby` ]]; then
    ruby_id=∫`echo $(ruby -v)|awk '{print $2}'`
  fi
  printf "%s" "${ruby_id}"
}

ps1_rbenv() {
  # set -e
  #
  # version_string=$(rbenv version-name)
  # case ${version_string%-*} in
  #   1.8.6) version_string="❻" ;;
  #   1.8.7) version_string="❼" ;;
  #   1.9.1) version_string="❶" ;;
  #   1.9.2) version_string="❷" ;;
  #   1.9.3) version_string="❸" ;;
  #   *) version_string="♢" ;;
  # esac
  #
  # [ -f "$(pwd)/.rbenv-gemsets" ] && gemset_string=" ⟡$(rbenv gemset active | cut -d' ' -f1)"
  # if [ ! $version_string = '' ]; then
  #   printf "$version_string$gemset_string"
  # fi
  local ver=`ruby -v`
  local plvl=`echo $ver|awk '{print $2}'`
  if [ ! $plvl = '' ]; then
    printf "$plvl"
  fi
}

ps1_prompt_char() {
  if [[ "$UID" = "0" ]]; then
    printf '\#'
  else
    printf '\$'
  fi
}

# Source the chosen theme:
themefile="${dot_env_path}/themes/${theme}/theme.sh"
if [[ -f "${themefile}" ]]; then
  source "${themefile}"
else
  source "${dot_env_path}/themes/default/theme.sh"
fi
