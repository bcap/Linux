path=(
    # go stuff downloaded with go get
    $HOME/go/bin
    # rust stuff
    $HOME/.cargo/bin
    # dotnet stuff
    $HOME/.dotnet/tools
    # keep what is defined in the base zsh profile (some installers change the base profile directly)
    $path
)

HISTSIZE=$((1000))
SAVEHIST=$((1000 * 1000))
HISTFILE=~/.zsh-history

export EDITOR="vim"
export PAGER="less"
export LESS="--chop-long-lines -R --shift 0.3"
export DISPLAY=:0

# fzf
source /usr/share/zsh/plugins/fzf/fzf.plugin.zsh

# #################
# Options
# #################

# Reference at http://zsh.sourceforge.net/Doc/Release/Options.html

setopt correct
unsetopt notify
setopt always_to_end
unsetopt auto_cd
setopt auto_menu
unsetopt menu_complete
setopt auto_pushd
unsetopt cdablevars
setopt complete_in_word
setopt extended_history
unsetopt flowcontrol
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
unsetopt hist_no_functions
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt inc_append_history_time
setopt interactivecomments
setopt long_list_jobs
setopt multios
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushdminus
unsetopt share_history
unsetopt bg_nice
unsetopt ignore_eof
unsetopt force_float


# #################
# Misc configs
# #################

# set max open files to 100k at minimum
[ $(ulimit -n) -lt 100000 ] && ulimit -n 100000


# #################
# Aliases
# #################

alias -g G='| grep -i '
alias -g H='| head -n 20 '
alias -g T='| tail -n 20 '
alias -g L='| less '
alias -g V='| vim - '
alias -g S='| sort '
alias -g SN='| sort -n '
alias -g SU='| sort | uniq -c'
alias -g CT='| column -t'
alias -g NL='| wc -l'
alias -g N='> /dev/null 2>&1 '
# http://stackoverflow.com/questions/1508490/how-can-i-erase-the-current-line-printed-on-console-in-c-i-am-working-on-a-lin
alias -g SAME='| awk '\''{printf "%c[2K\r%s", 27, $0} END{printf "\n"}'\'
alias -g SUM='| awk '\''{sum+=$1} END{print sum}'\'
alias -g AVG='| awk '\''{avg=(avg * l + $1) / (l + 1); l++} END{print avg}'\'
alias -g NUMBERED='| awk '\''BEGIN{l=1} {printf "%d: %s\n", l, $0; l++}'\'
alias -g SLOW='| pv -q -L 20'

alias ls='ls --color=auto'
alias ll='ls -lhp'
alias la='ll -A'

alias diff='diff -u'

alias grep='grep --color'

alias today='date +%Y-%m-%d'
alias now='date +%Y-%m-%dT%H:%M:%S'

alias tmp='cd $(mktemp -d)'

alias gpg=' \
    gpg \
    --personal-cipher-preferences AES256 \
    --personal-compress-preferences ZLIB \
    --armor \
'
alias encrypt-with-pass='gpg --symmetric'
alias encrypt-with-key='gpg --encrypt --sign --recipient polaco@gmail.com'
alias decrypt='gpg -d'
alias parallel='parallel --gnu'
alias bell='echo -e "\a"'
alias reload-zshrc='source ~/.zshrc'

alias k='kubectl'
alias mk='minikube'

# #################
# Completion
# #################

zmodload -i zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zshcache/
zstyle '*' single-ignored show

autoload -U compinit
compinit -i

# #################
# Key Bindings
# #################

bindkey -e
bindkey '^R' history-incremental-search-backward
# replace Ctrl+R with fzf history widget
bindkey '^R' fzf-history-widget
bindkey '^[[1;5C' forward-word  # Ctrl RightArrow
bindkey '^[[1;5D' backward-word # Ctrl LeftArrow
bindkey "^[[3~"   delete-char
bindkey "^[3;5~"  delete-char
bindkey "\e[3~"   delete-char
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# expands global aliases on the space keystroke
# copied from http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
# The regex was slighly modified
globalias() {
   if [[ $LBUFFER =~ '(^| )[A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}
zle -N globalias
bindkey " " globalias
bindkey -M isearch " " magic-space # normal space during searches


# #################
# Init commands
# #################

source ~/init.sh
