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
    'p')   cd ~/workspace/projects ;;
    'phd') cd ~/workspace/projects/phd ;;
    'pl')  cd ~/workspace/playground ;;
    's')   cd ~/workspace/sites ;;
    't')   cd ~/workspace/trunk ;;
    *) echo 'Destination unknown :(' ;;
  esac
}
genpass() {
  pwgen -ny 12 1 | xclip -sel c
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
alias oo='pcmanfm .'
alias xc='xclip'
alias xx='xclip -o'
alias xc.ssh='cat ~/.ssh/id_rsa.pub | xc'

alias ecl='emacsclient -a "" -t'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias ls='ls --color=auto -h'
alias lsr='ls -ltr'

alias ipy=ipython3
alias jyp=jupyter-notebook

alias c.bashrc='$EDITOR ~/.bashrc'
alias c.compton='$EDITOR ~/.config/compton.conf'
alias c.i3='$EDITOR ~/.config/i3/config'
alias c.a='$EDITOR ~/.config/ech/autostart.sh'
alias c.xres='$EDITOR ~/.Xresources'
alias c.info='$EDITOR ~/workspace/notes/info.org'
alias c.diary='$EDITOR ~/workspace/notes/diary.org'
alias c.todo='$EDITOR ~/workspace/notes/todo.org'
alias c.stuff='$EDITOR ~/workspace/notes/stuff.org'

alias git.sync='git commit -m "sync" && git push'
# }
# Environment {
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

#EDITOR="emacsclient -t"
#VISUAL="emacsclient -c -a emacs"
EDITOR="vim"
VISUAL="gvim"

export PATH=$HOME/workspace/bin:$PATH
export XDG_DATA_DIRS=~/.local/share/flatpak/exports/share/applications:$XDG_DATA_DIRS
# }
