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
    'h')   cd ~ ;;
    'w')   cd ~/workspace ;;
    'd')   cd ~/workspace/dev ;;
    'n')   cd ~/workspace/notes ;;
    'phd') cd ~/workspace/phd/in-work ;;
    'p')   cd ~/workspace/projects/in-work ;;
    't')   cd ~/workspace/trunk ;;
    's')   cd ~/workspace/sites ;;
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
sync.thesis () {
    curl --user "nid=mm.st:`pass fm/dav`" --basic -T \
         "$HOME/workspace/phd/in-work/thesis/thesis.html" \
         "https://myfiles.fastmail.com/trunk.oscii.ru/thesis/index.html"
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
    alias c.bashrc='vim ~/.bashrc'
    alias c.compton='vim ~/.config/compton.conf'
    alias c.i3='ecl ~/.config/i3/config'
    alias c.xres='ecl ~/.Xresources'
    alias c.info='ecl ~/workspace/notes/info.org'
    alias c.todo='ecl ~/workspace/notes/todo.org'
    alias c.stuff='ecl ~/workspace/notes/stuff.org'
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
   [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
    shopt -s checkwinsize
    shopt -s expand_aliases
    shopt -s histappend

    EDITOR=""
    EDITOR="emacsclient -t"
    VISUAL="emacsclient -c -a emacs"
    ;;
esac

export PATH=$HOME/workspace/bin:$PATH
# }
