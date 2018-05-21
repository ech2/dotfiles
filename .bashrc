#!/bin/bash
# vim: foldmarker={,} foldlevel=0 foldmethod=marker:

# Prompt {
function prompt() {
  local n="\e[0m"
  local b="\e[1m"
  local it="\e[3m"
  local u="\e[4m"
  local s="\e[9m"
  
  PS1="$n[$b\u@\h$n \w]\n$ "
}
prompt
if [[ -f ~/.dir_colors ]]; then eval $(dircolors -b ~/.dir_colors); fi
# }
# Helpers {
what_os() {
  case `uname` in
    'Darwin') echo 'mac' ;;
    'Linux') echo 'linux' ;;
    *) echo 'unknown' ;;
  esac
}
mcd() {
  if [[ $# -eq 1 ]]; then
    mkdir -p "$1" && cd "$1"
  fi
}
goto() {
  if [ $# -eq 0 ]; then echo 'No parameters'; return; fi
  case $1 in
    'w') cd ~/workspace ;;
    'phd') cd ~/workspace/phd/in-work ;;
    'd') cd ~/workspace/dev ;;
    'df') cd ~/workspace/dotfiles ;;
    'p') cd ~/workspace/projects/in-work ;;
    't') cd ~/workspace/trunk ;;
    's') cd ~/workspace/sites ;;
    'n') cd ~/workspace/notes ;;
    *) echo 'Destination unknown :(' ;;
  esac
}
genpass() {
  openssl rand -base64 72 | tr -cd "[[:alnum:]]._-" | cut -c1-"$1"
}
ulf() {
  if [ $# -eq 0 ]; then
    echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi
  tmpfile=$( mktemp -t transferXXX )
  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
  else
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
  fi
  cat $tmpfile
  echo
  rm -f $tmpfile
}
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
sync.darwin() {
  rsync -az --progress --exclude-from=~/workspace/.rsync-exclude ~/workspace ech@darwin:~/workspace
}
# }
# Aliases {
case `what_os` in
  'mac')
    alias xc='pbcopy'
    alias xx='pbpaste'
    alias ls='ls -GFh'
    alias oo='open .'
    alias lockscreen='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
   ;;
  'linux')
    alias xc='xclip'
    alias xx='xclip -o'
    alias oo='pcmanfm .'
    alias ecl='emacsclient -a "" -t'
    alias ls='ls --color=auto -h'
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
    alias c.bashrc='ecl ~/.bashrc'
    alias c.compton='ecl ~/.config/compton.conf'
    alias c.i3='ecl ~/.config/i3/config'
    alias c.xres='ecl ~/.Xresources'
    alias c.nvim='ecl ~/.config/nvim/init.vim'
    alias cal.sync='calcurse-caldav --password=$(pass show fm-caldav)'
    alias vim='nvim'
    ;;
esac

alias lsr='ls -ltr'
alias xc.ssh='cat ~/.ssh/id_rsa.pub | xc'
alias grep='grep --color'
alias jyp=jupyter-notebook
alias ipy=ipython3
# }
# Environment {
case `what_os` in
  'mac')
    export PATH=/usr/local/bin:/usr/local/sbin:/Users/ech/Library/Haskell/bin:$PATH
    ;;
  'linux')
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export PATH=$HOME/.gem/ruby/2.4.0/bin:$HOME/.cargo/bin:$PATH
    export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
    [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
    shopt -s checkwinsize
    shopt -s expand_aliases
    # export QT_SELECT=4
    shopt -s histappend
    export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
    ;;
esac

export PATH=$HOME/workspace/bin:$PATH
export GOPATH=$HOME/workspace/dev/go
# }
