# initial line break
SPACESHIP_PROMPT_ADD_NEWLINE=false

SPACESHIP_USER_SHOW=always
SPACESHIP_USER_SUFFIX=""
SPACESHIP_USER_COLOR=215        # SandyBrown

SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=""
SPACESHIP_HOST_COLOR=215        # SandyBrown
SPACESHIP_HOST_COLOR_SSH=215    # SandyBrown

SPACESHIP_DIR_COLOR="cyan"
SPACESHIP_DIR_PREFIX=" "
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_DIR_LOCK_COLOR=203    # IndinaRed
SPACESHIP_DIR_TRUNC=1

SPACESHIP_GIT_PREFIX="("
SPACESHIP_GIT_SUFFIX=") "
# SPACESHIP_GIT_PREFIX="git:("
# SPACESHIP_GIT_SUFFIX=") "
# SPACESHIP_GIT_SYMBOL=""
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_STATUS_COLOR="yellow"
SPACESHIP_GIT_STATUS_PREFIX="["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_BRANCH_COLOR=203  # IndianRed

SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SYMBOL="%{➜ %2G%}"
SPACESHIP_CHAR_SUFFIX=""

# SPACESHIP_VI_MODE_INSERT="%F{blue}%{[I]%1G%}"
# SPACESHIP_VI_MODE_NORMAL="%F{white}[%F{203}%{N%1G%}%F{white}]%f"
# SPACESHIP_VI_MODE_INSERT="%F{white}[%F{white}%{I%1G%}%F{white}]%f"
# SPACESHIP_VI_MODE_NORMAL="%F{white}[%F{yellow}%{N%1G%}%F{white}]%f"
# SPACESHIP_VI_MODE_SUFFIX=" "

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  # docker        # Docker section
  # line_sep      # Line break
  # conda
  # vi_mode
  char          # Prompt character
)
