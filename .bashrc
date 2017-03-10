# Source global bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# # Sequences
# OPEN_ESC="\["
# CLOSE_ESC="\]"

# # Needed for all strings injected into PS1
# function _escape() {
#     echo -nE "${1//\\/\\\\}"
# }

# # https://github.com/nojhan/liquidprompt/blob/master/liquidprompt#L222
# function _config() {
#     local ti_sgr0="$( { tput sgr0 || tput me ; } 2>/dev/null )"
#     local ti_bold="$( { tput bold || tput md ; } 2>/dev/null )"
#     local ti_setat() { tput setaf "$1" ; }
#     local ti_setab() { tput setab "$!" ; }

#     local BLACK=${OPEN_ESC}$(ti_setaf 0)${CLOSE_ESC}                 # 0
#     local BOLD_GRAY=${OPEN_ESC}${ti_bold}$(ti_setaf 0)${CLOSE_ESC}   # 0b

#     local RED=${OPEN_ESC}$(ti_setaf 1)${CLOSE_ESC}                   # 1
#     local BOLD_RED=${OPEN_ESC}${ti_bold}$(ti_setaf 1)${CLOSE_ESC}    # 1b

#     local GREEN=${OPEN_ESC}$(ti_setaf 2)${CLOSE_ESC}                 # 2
#     local BOLD_GREEN=${OPEN_ESC}${ti_bold}$(ti_setaf 2)${CLOSE_ESC}  # 2b

#     local YELLOW=${OPEN_ESC}$(ti_setaf 3)${CLOSE_ESC}                # 3
#     local BOLD_YELLOW=${OPEN_ESC}${ti_bold}$(ti_setaf 3)${CLOSE_ESC} # 3b

#     local BLUE=${OPEN_ESC}$(ti_setaf 4)${CLOSE_ESC}                  # 4
#     local BOLD_BLUE=${OPEN_ESC}${ti_bold}$(ti_setaf 4)${CLOSE_ESC}   # 4b

#     local PURPLE=${OPEN_ESC}$(ti_setaf 5)${CLOSE_ESC}                # 5
#     local PINK=${OPEN_ESC}${ti_bold}$(ti_setaf 5)${CLOSE_ESC}        # 5b

#     local CYAN=${OPEN_ESC}$(ti_setaf 6)${CLOSE_ESC}                  # 6
#     local BOLD_CYAN=${OPEN_ESC}${ti_bold}$(ti_setaf 6)${CLOSE_ESC}   # 6b

#     local WHITE=${OPEN_ESC}$(ti_setaf 7)${CLOSE_ESC}                 # 7

#     NO_COL=${OPEN_ESC}${ti_sgr0}${CLOSE_ESC}

#     COLOR_ERR=$PURPLE
#     COLOR_HOST=''
#     COLOR_MARK=$BOLD
#     COLOR_PATH=$BOLD
#     COLOR_TIME=$BLUE
#     COLOR_USER_LOGGED=''
#     MARK_STASH='+'
#     VCS_COLOR_COMMITS=$YELLOW
#     VCS_COLOR_COMMITS_BEHIND=$BOLD_RED
#     VCS_COLOR_CHANGES=$RED


# }

# # Git

# # Get branch name of current directory.
# # https://github.com/nojhan/liquidprompt/blob/master/liquidprompt#L845
# _git_branch() {
#     \git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

#     local branch
#     if branch="$(\git symbolic-ref --short -q HEAD)"; then
#         # Get the branch name
#         echo $branch
#     else
#         # In a detached head state use commit instead
#         \git rev-parse --short -q HEAD
#     fi
# }

# # Display additional information if HEAD is in:
# # merging, rebasing, or cherry-picking state
# _git_head_status() {
#     local gitdir
#     gitdir="$(\git rev-parse --git-dir 2>/dev/null)"
#     if [[ -f "${gitdir}/MERGE_HEAD" ]]; then
#         echo " MERGING"
#     elif [[ -d "${gitdir}/rebase-apply" || -d "${gitdir}/rebase-merge" ]]; then
#         echo " REBASING"
#     elif [[ -f "${gitdir}/CHERRY_PICK_HEAD" ]]; then
#         echo " CHERRY-PICKING"
#     fi
# }

# # Set color depending on branch state:
# # - green   if repo is current
# # - yellow  if there are commits not yet pushed
# # - red     if there are changes to commit
# # Add the number of pending commits and the impacted lines
# # https://github.com/nojhan/liquidprompt/blob/master/liquidprompt#L884
# _git_branch_color() {
#     local branch
#     branch="$(_lp_git_branch)"

#     if [[ -n "$branch" ]]; then
#         local end
#         end="${VCS_COLOR_CHANGES}$(_git_head_status)${NO_COL}"

#         if \git rev-parse --verify -q refs/stash >/dev/null; then
#             end="$VCS_COLOR_COMMITS$MARK_STASH$end"
#         fi

#         local remote
#         remote="$(\git config --get branch.${branch}.remote 2>/dev/null)"

#         local has_commit=""
#         local commit_ahead
#         local commit_behind
#         if [[ -n "$remote" ]]; then
#             local remote_branch
#             remote_branch="$(\git config --get branch.${branch}.merge)"

#             if [[ -n "$remote_branch" ]]; then
#                 remote_branch=${remote_branch/refs\/heads/refs\/remotes\/$remote}
#                 commit_ahead="$(\git rev-list --count $remote_branch..HEAD 2>/dev/null)"
#                 commit_behind="$(\git rev-list --count HEAD..$remote_branch 2>/dev/null)"

#                 if [[ "$commit_ahead" -ne "0" && "$commit_behind" -ne "0" ]]; then
#                     has_commit="${VCS_COLOR_COMMITS}+$commit_ahead${NO_COL}/${VCS_COLOR_COMMITS_BEHIND}-$commit_behind${NO_COL}"
#                 elif [[ "$commit_ahead" -ne "0" ]]; then
#                     has_commit="${VCS_COLOR_COMMITS}$commit_ahead${NO_COL}"
#                 elif [[ "$commit_behind" -ne "0" ]]; then
#                     has_commit="${VCS_COLOR_COMMITS_BEHIND}-$commit_behind${NO_COL}"
#                 fi
#             fi
#         fi

#         local ret
#         local shortstat # only to check for uncommitted changes
#         shortstart="$(ALL=C \git diff --shortstat HEAD 2>/dev/null)"

#         if [[ -n "$shortstat" ]]; then
#             local u_stat # shortstat of unstaged changes
#             u_stat="$(ALL=C \git diff --shortstat 2>/dev/null)"
#             u_stat=${u_stat/*changed, /} #remove "n file(s) changed"

#             local i_lines # inserted lines
#             if [[ "$u_stat" = *insterion* ]]; then
#                 i_lines=${u_stat/ inser*}
#             else
#                 i_lines=0
#             fi

#             local d_lines # deleted lines
#             if [[ "$u_stat" = *deletion* ]]; then
#                 d_lines=${u_stat/*\(+\), }
#                 d_lines=${d_lines/ del*/}
#             else
#                 d_lines=0
#             fi

#             local has_lines
#             has_lines="+$i_lines/-$d_lines"

#             if [[ -n "$has_commit" ]]; then
#                 # Changes to commit and commits to push
#                 ret="${VCS_COLOR_CHANGES}${branch}${NO_COL}(${VCS_COLOR_DIFF}$has_lines${NO_COL},$has_commit)"
#             else
#                 # Changes to commit
#                 ret="${VCS_COLOR_CHANGES}${branch}${NO_COL}(${VCS_COLOR_DIFF}$has_lines${NO_COL})"
#             fi
#         elif [[ -n "$has_commit" ]]; then
#             # Some commit(s) to push
#             if [[ "$commit_behind" -gt "0" ]]; then
#                 ret="${VCS_COLOR_COMMITS_BEHIND}${branch}${NO_COL}($has_commit)"
#             else
#                 ret="${VCS_COLOR_COMMITS}${branch}${NO_COL}($has_commit)"
#             fi
#         else
#             # Nothing to commit or push
#             ret="${VCS_COLOR_UP}${branch}"
#         fi
#         echo -nE "$ret$end"
#     fi
# }

export PS1='[\A] \h:\W \u \$ '

# Bash set
set -o notify
set -o noclobber
set -o ignoreeof

# Bash shopt
shopt -s cdspell
#shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
#shopt -s direxpand
#shopt -s dirspell
shopt -s histreedit
shopt -s histverify
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s nocaseglob

# Aliases
alias df='df -kh' # Use 1024 human-readable units
alias du='du -kh' # Use 1024 human-readable units
# Alias (ls)
alias ls='ls -hG' # Use units, colorize output
alias ll='ls -lv'

# Bash programmable completion
shopt -s extglob

complete -A hostname        rsh rcp telnet rlogin ftp ping
complete -A export          printenv
complete -A variable        export local readonly unset
complete -A enabled         builtin
complete -A alias           alias unalias
complete -A function        function
complete -A user            su mail finger

complete -A helptopic       help
complete -A shopt           shopt
complete -A stopped -P '%'  bg
complete -A job -P '%'      fg jobs disown

complete -A directory       mkdir rmdir
complete -A directory       -o default cd

# less
export PAGER='less'
# less man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Git
if [ -f /usr/local/share/gitprompt.sh ]; then
    GIT_PROMPT_THEME=Default
    . /usr/local/share/gitprompt.sh
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="/Users/sumantmanne/src/rust/src/"

# OS X >= 10.11 (El Capitan), does not include OpenSSL
export OPENSSL_INCLUDE_DIR="$(brew --prefix openssl)/include"
export OPENSSL_LIB_DIR="$(brew --prefix openssl)/lib"
