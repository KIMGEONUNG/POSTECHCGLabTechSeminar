# build_prompt() {
#   RETVAL=$?
#   prompt_status
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
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

# Show only current directory
prompt_dir() {
  prompt_segment blue black '%2~'
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "\n➜%{%f%}"
  CURRENT_BG=''
}
