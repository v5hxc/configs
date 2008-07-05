# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt   appendhistory allexport
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
autoload colors zsh/terminfo

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# default apps
PAGER='less'
EDITOR='vim'

# prompt
PS1="${PR_BLUE}gglucas${PR_LIGHT_GREEN}:${PR_MAGENTA}%~${PR_NO_COLOR}> "
#RPS1="$terminfo[color14](%D{%d %b, %H:%M})$PR_NO_COLOR"

# vi editing
bindkey -v
bindkey ' ' magic-space
bindkey '^I' complete-word
bindkey '^P' history-complete-older
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey "^r" history-incremental-search-backward
bindkey "^[OA" up-line-or-search
bindkey "^[OB" down-line-or-search
bindkey "^[[A" up-line-or-search
bindkey "^K" kill-line
bindkey "^[[B" down-line-or-search

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -U compinit
compinit

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias ls='ls --color=auto'

# functions
mdc() { mkdir -p "$1" && cd "$1" }
setenv() { export $1=$2 }  # csh compatibility
pc() { awk "{print \$$1}" }
rot13 () { tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" }
