# Source global bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export PS1="\[\033[1;36m\][\A] \[\033[1;31m\]\W \[\033[0m\]\u \[\033[1;37m\]$\[\033[0m\] "

# Bash set
set -o notify
set -o noclobber
set -o ignoreeof

# Bash shopt
shopt -s cdspell
#shopt -s checkjobs
#shopt -s checkwinsize
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
