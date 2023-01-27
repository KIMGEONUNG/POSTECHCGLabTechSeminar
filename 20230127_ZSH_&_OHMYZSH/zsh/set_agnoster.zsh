# build_prompt() {
#   RETVAL=$?
#   prompt_status     # success or failure if failure output x
#   prompt_virtualenv
#   prompt_aws
#   prompt_context
#   prompt_dir
#   prompt_git
#   prompt_bzr
#   prompt_hg
#   prompt_end
# }

build_prompt() {
  RETVAL=$?
  prompt_status
  # prompt_virtualenv
  # prompt_aws
  prompt_context
  prompt_dir
  # prompt_git
  # prompt_bzr
  # prompt_hg
  prompt_end
}

######################################################
# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

######################################################
# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  # [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
  # echo $CURRENT_BG # NONE
  # echo $CURRENT_FG # black
  [[ -n "$symbols" ]] && prompt_segment '' yellow "$symbols"
}

######################################################
# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # echo %n # kkang
    # echo %m # cglabmark
    # echo $CURRENT_BG # ''
    # echo $CURRENT_FG # black
    CURRENT_BG=yellow
    prompt_segment yellow black "%(!.%{%F{black}%}.) %n@%m"
  fi
}

######################################################
# Show only current directory
prompt_dir() {
  prompt_segment 39d $CURRENT_FG '%2~'
}

######################################################
# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    # default case (echo -n means no newline)
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    # abnormal case
    echo -n "%{%k%}"
    echo 2222222222
  fi
  echo -n "\n➜%{%f%}"
  CURRENT_BG=''
}
