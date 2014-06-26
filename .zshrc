
# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8


## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"
setopt transient_rprompt

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
alias screen="screen -U -D -RR"
alias hg="nocorrect hg"
# alias npm="nocorrect npm"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias sgi32="sudo env ARCHFLAGS="-Os -arch i386 -fno-common" gem install"
alias sgi64="sudo env ARCHFLAGS="-Os -arch x86_64 -fno-common" gem install"
alias sgi="sgi64"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    alias Emacs='open -a /Applications/Emacs.app/Contents/MacOS/Emacs'
    alias emacs="/usr/local/Cellar/emacs/23.3b/Emacs.app/Contents/MacOS/Emacs -nw"
    # alias vi=vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.zshrc "$@"'
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports()
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
export LC_CTYPE="ja_JP.UTF-8"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$HOME/download/flex_sdk_3/bin:$PATH
export JRUBY_HOME=~/jruby
export GAEJ_HOME=~/appengine-java-sdk-1.2.2
export PATH=$PATH:$JRUBY_HOME/bin:$GAEJ_HOME/bin
export PATH=~/chromium/depot_tools:"$PATH"
export PATH=~/src/gistp:"$PATH"
export PATH=~/hatena-diary-writer:"$PATH"
export PATH=/usr/local/mysql/bin:"$PATH"
export PATH=~/perl5/perlbrew/bin:"$PATH"
export PATH="$PATH":"$HOME/bin"

case "${OSTYPE}" in
darwin*)
    export PATH=/usr/local/Cellar/android-sdk/r7/bin:"$PATH"
    export PATH=/usr/local/Cellar/android-sdk/r7/tools:"$PATH"
    export PATH="$HOME/Library/Haskell/bin:$PATH"
    ;;
esac

export GISTY_DIR="$HOME/gists"

[[ -s $HOME/perl5/perlbrew/etc/bashrc ]] && source $HOME/perl5/perlbrew/etc/bashrc
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

if [ -s $HOME/.pythonbrew/etc/bashrc ]
then
  source $HOME/.pythonbrew/etc/bashrc
  export VIRTUALENVWRAPPER_PYTHON=$HOME/.pythonbrew/pythons/Python-2.5.5/bin/python
  source $HOME/.pythonbrew/pythons/Python-2.5.5/bin/virtualenvwrapper.sh
  export VIRENV_USE_DISTRIBUTE=1
  export WORKON_HOME=$HOME/.virtualenvs
fi

if [ -s /usr/share/vim/vim73/macros/less.sh ]
then
  alias vless="/usr/share/vim/vim73/macros/less.sh"
fi

if [ -s /usr/share/vim/vimcurrent/macros/less.sh ]
then
  alias vless="/usr/share/vim/vimcurrent/macros/less.sh"
fi

alias hg="hg --encoding=utf-8"

# source $HOME/.nvm/nvm.sh
alias pad="plackup -MPlack::App::Directory \
          -e 'Plack::App::Directory->new->to_app'"

alias ec="emacsclient -n"

export EDITOR=vim
alias be='bundle exec'

perl -wle \
'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
     PATH > $HOME/.emacs.d/shellenv.el

export GOOGLE_KEY=anonymous
export GOOGLE_SECRET=anonymous

export PATH=$HOME/.nodebrew/current/bin:$PATH
[[ -x "`which npm 2>/dev/null`" ]] && . <(npm completion)
export JSTESTDRIVER_HOME=~/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# rbenv
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
  eval "$(rbenv init -)"
fi

# plenv
if [ -d ${HOME}/.plenv  ] ; then
  export PATH=${HOME}/.plenv/bin/:${HOME}/.plenv/shims:${PATH}
  eval "$(plenv init -)"
fi

source ~/.mysqlenv/etc/bashrc
export LDFLAGS=-L/usr/local/opt/readline/lib
export CPPFLAGS=-I/usr/local/opt/readline/include
export GOPATH=$HOME/work/golang
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH":$HOME/bin/depot_tools
