# bashrc
# Create the link for the imported bashrc
if ! [ -L ~/.bashrc ]; then
  rm ~/.bashrc
  ln -s ~/.scripts/.bashrc ~/.bashrc
fi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

git_status() {
  BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if ! [ -z $BRANCH ]; then
    printf "\e[1;37m|\e[0;93m$BRANCH"
    CHANGES=$((`git status | grep -0 'modified\|deleted' | wc -l` + `git ls-files --others --exclude-standard | wc -l`))
    if [ $CHANGES -gt 0 ]; then
      printf "[$CHANGES]"
    fi
  fi
}
W='$(printf "\[\e[1;37m\]")'
R='$(printf "\[\e[2;31m\]")'
G='$(printf "\[\e[0;32m\]")'
B='$(printf "\[\e[0;34m\]")'
Y='$(printf "\[\e[0;93m\]")'
RESET='$(printf "\[\e[1;0m\]")'
LASTCOMMAND='\[\e[0;33m\]\# $(if [[ $? == 0 ]]; then echo "\[\033[01;32m\]\342\234\223"; else echo "\[\033[01;31m\]\342\234\227"; fi)'
BRANCH='$(git_status)'
if [ `whoami` == 'root' ]; then
  PS1="$R[$LASTCOMMAND$W|$R\u$W|$B\w$BRANCH$R]$RESET:"
else
  PS1="$G[$LASTCOMMAND$W|$G\u$W|$B\w$BRANCH$G]$RESET:"
fi

# Add .scripts to path
PATH=$PATH':/sbin'
PATH=$PATH':~/.scripts'
PATH=$PATH':/usr/local/nvm/v5.4.1/bin'
PATH=$PATH':/home/jameson/MonkeyXFree84f/bin'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi



## aliases

alias ll='ls -lah'
alias r='source ~/.bashrc;reset'
alias ip="wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]|.]//g'"
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
alias vssh="vagrant ssh $@"

## functions
syncscripts() {
  CD=$(pwd)
  git --version > /dev/null 2>&1 || { echo >&2 "Git isn't installed... Aborting"; exit 1; }
  cd ~/.scripts
  git pull
  git commit -am"autosync $(date)"
  git push
  cd $CD
  source ~/.bashrc
}

userprocs() {
 ps aux | awk '/'$1'/ { print $2}'
}

fman(){ man $@ | gedit;}

gkill(){ for p in `pgrep $@`; do kill $p; done;}

countmail(){ zenity --info --text=$(zenity --text-info --editable --title="paste in exim log" | grep "<=" | wc -l)" emails sent";}

countspam(){ 
if [ -z $@ ]; then dom=$(zenity --entry --text "enter domains, separated by |");else dom=$@;fi
list=$(zenity --text-info --editable --title="paste in exim log" | 
egrep -o "<=.{1,30}@($dom)" | sort | uniq -c | sort -nr | sed -e 's/\(\d+ <=\)/\n\1/')
echo "$list" | zenity --text-info --title "Sending Totals" &
}

uptime() {
_time=$(awk -F '.' '{print $1}' /proc/uptime)
`printf "$_time\n" | egrep "[^0-9]" 1>/dev/null 2>&1`
if   [ $? != 1 ];then
     printf "the arg passed to the script contains\n"
     printf "non-numerical characters, i'm exiting\n"
     exit 98
fi
   _days=`printf "scale=0;$_time / 86400\n" | bc -l`
   _hours=`printf "scale=0;($_time / 3600) - ($_days * 24)\n"  | bc -l `
   _minutes=`printf "scale=0;($_time / 60) - ($_days * 1440) - ($_hours * 60)\n" | bc -l`
   _seconds=`printf "scale=0;$_time %% 60\n" | bc -l`
printf "${_days:-0}D ${_hours:-0}H "
printf "${_minutes:-0}M ${_seconds:-0}S\n"
}

pagespeed(){
for i in ${@}; do
    local site=$1
    echo $site
    echo ${site} | sed -n 's/./-/gp'
    curl -w '
    Lookup time:\t%{time_namelookup} s
    Connect time:\t%{time_connect} s
    Pre-transfer time:\t%{time_pretransfer} s
    Time to first packet:\t%{time_starttransfer} s
    Size download:\t%{size_download} bytes
    Speed download:\t%{speed_download} bytes/s

    Total time:\t%{time_total} s
    ' -o /dev/null -s $site
    echo
done
}
progress(){
    [[ -z $1 || -z $2 || -z $3 ]] && exit  # on empty param...

    percent=$3
    completed=$(( $percent / 2 ))
    remaining=$(( 50 - $completed ))

    echo -ne "\r\t["
    printf "%0.s=" `seq $completed`
    echo -n ">"
    [[ $remaining != 0 ]] && printf "%0.s." `seq $remaining`
    echo -n "] $percent% ($2)  "
}
typewriter(){
    text="$1"
    if [[ -z $2 ]];then  delay=0.01
    else delay="$2"; fi
    for i in $(seq 0 $(expr length "${text}")) ; do
        echo -ne "${text:$i:1}"
        sleep ${delay}
    done
}
colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}

wftp(){
 wget -m ftp://$1 -o $2 --ask-password
}

# alter the default colors to make them a bit prettier
echo -en "\e]P01B1D1E" #black      
echo -en "\e]P1F92672" #darkred    
echo -en "\e]P282B414" #darkgreen  
echo -en "\e]P3FD971F" #brown      
echo -en "\e]P456C2D6" #darkblue   
echo -en "\e]P58C54FE" #darkmagenta
echo -en "\e]P6465457" #darkcyan   
echo -en "\e]P7CCCCC6" #lightgrey  
echo -en "\e]P8505354" #darkgrey   
echo -en "\e]P9FF5995" #red        
echo -en "\e]PAB6E354" #green      
echo -en "\e]PBFEED6C" #yellow     
echo -en "\e]PC8CEDFF" #blue       
echo -en "\e]PD9E6FFE" #magenta    
echo -en "\e]PE899CA1" #cyan       
echo -en "\e]PFF8F8F2" #white      
clear #for background artifacting


## colorize ls
ls --color=al > /dev/null 2>&1 && alias ls='ls -F --color=al' || alias ls='ls -G'

## color pallette
LS_COLORS=''
LS_COLORS=$LS_COLORS:'rs=0'
LS_COLORS=$LS_COLORS:'di=01;34'     # directory
LS_COLORS=$LS_COLORS:'ln=01;36'     # symlink
LS_COLORS=$LS_COLORS:'pi=40;33'     # fifo file
LS_COLORS=$LS_COLORS:'so=01;35'     # socket file
LS_COLORS=$LS_COLORS:'ex=01;32'     # executable
LS_COLORS=$LS_COLORS:'bd=40;33;01'  # block device/file
LS_COLORS=$LS_COLORS:'cd=40;33;01'  # character special file
LS_COLORS=$LS_COLORS:'or=40;31;01'  # orphaned symlink
LS_COLORS=$LS_COLORS:'mh=00'        # file with multiple links
LS_COLORS=$LS_COLORS:'ca=30;41'     # file with capability
LS_COLORS=$LS_COLORS:'do=01;35'     # door
LS_COLORS=$LS_COLORS:'su=37;41'     # setuid
LS_COLORS=$LS_COLORS:'sg=30;43'     # setgid
LS_COLORS=$LS_COLORS:'ow=40;34'     # directory is other writable
LS_COLORS=$LS_COLORS:'tw=46;30'     # directory is sticky and other writable
LS_COLORS=$LS_COLORS:'st=44;37'     # directory is sticky
LS_COLORS=$LS_COLORS:'*.tar=01;31'
LS_COLORS=$LS_COLORS:'*.tgz=01;31'
LS_COLORS=$LS_COLORS:'*.arc=01;31'
LS_COLORS=$LS_COLORS:'*.arj=01;31'
LS_COLORS=$LS_COLORS:'*.taz=01;31'
LS_COLORS=$LS_COLORS:'*.lha=01;31'
LS_COLORS=$LS_COLORS:'*.lz4=01;31'
LS_COLORS=$LS_COLORS:'*.lzh=01;31'
LS_COLORS=$LS_COLORS:'*.lzma=01;31'
LS_COLORS=$LS_COLORS:'*.tlz=01;31'
LS_COLORS=$LS_COLORS:'*.txz=01;31'
LS_COLORS=$LS_COLORS:'*.tzo=01;31'
LS_COLORS=$LS_COLORS:'*.t7z=01;31'
LS_COLORS=$LS_COLORS:'*.zip=01;31'
LS_COLORS=$LS_COLORS:'*.z=01;31'
LS_COLORS=$LS_COLORS:'*.Z=01;31'
LS_COLORS=$LS_COLORS:'*.dz=01;31'
LS_COLORS=$LS_COLORS:'*.gz=01;31'
LS_COLORS=$LS_COLORS:'*.lrz=01;31'
LS_COLORS=$LS_COLORS:'*.lz=01;31'
LS_COLORS=$LS_COLORS:'*.lzo=01;31'
LS_COLORS=$LS_COLORS:'*.xz=01;31'
LS_COLORS=$LS_COLORS:'*.bz2=01;31'
LS_COLORS=$LS_COLORS:'*.bz=01;31'
LS_COLORS=$LS_COLORS:'*.tbz=01;31'
LS_COLORS=$LS_COLORS:'*.tbz2=01;31'
LS_COLORS=$LS_COLORS:'*.tz=01;31'
LS_COLORS=$LS_COLORS:'*.deb=01;31'
LS_COLORS=$LS_COLORS:'*.rpm=01;31'
LS_COLORS=$LS_COLORS:'*.jar=01;31'
LS_COLORS=$LS_COLORS:'*.war=01;31'
LS_COLORS=$LS_COLORS:'*.ear=01;31'
LS_COLORS=$LS_COLORS:'*.sar=01;31'
LS_COLORS=$LS_COLORS:'*.rar=01;31'
LS_COLORS=$LS_COLORS:'*.alz=01;31'
LS_COLORS=$LS_COLORS:'*.ace=01;31'
LS_COLORS=$LS_COLORS:'*.zoo=01;31'
LS_COLORS=$LS_COLORS:'*.cpio=01;31'
LS_COLORS=$LS_COLORS:'*.7z=01;31'
LS_COLORS=$LS_COLORS:'*.rz=01;31'
LS_COLORS=$LS_COLORS:'*.cab=01;31'
LS_COLORS=$LS_COLORS:'*.jpg=01;35'
LS_COLORS=$LS_COLORS:'*.jpeg=01;35'
LS_COLORS=$LS_COLORS:'*.gif=01;35'
LS_COLORS=$LS_COLORS:'*.bmp=01;35'
LS_COLORS=$LS_COLORS:'*.pbm=01;35'
LS_COLORS=$LS_COLORS:'*.pgm=01;35'
LS_COLORS=$LS_COLORS:'*.ppm=01;35'
LS_COLORS=$LS_COLORS:'*.tga=01;35'
LS_COLORS=$LS_COLORS:'*.xbm=01;35'
LS_COLORS=$LS_COLORS:'*.xpm=01;35'
LS_COLORS=$LS_COLORS:'*.tif=01;35'
LS_COLORS=$LS_COLORS:'*.tiff=01;35'
LS_COLORS=$LS_COLORS:'*.png=01;35'
LS_COLORS=$LS_COLORS:'*.svg=01;35'
LS_COLORS=$LS_COLORS:'*.svgz=01;35'
LS_COLORS=$LS_COLORS:'*.mng=01;35'
LS_COLORS=$LS_COLORS:'*.pcx=01;35'
LS_COLORS=$LS_COLORS:'*.mov=01;35'
LS_COLORS=$LS_COLORS:'*.mpg=01;35'
LS_COLORS=$LS_COLORS:'*.mpeg=01;35'
LS_COLORS=$LS_COLORS:'*.m2v=01;35'
LS_COLORS=$LS_COLORS:'*.mkv=01;35'
LS_COLORS=$LS_COLORS:'*.webm=01;35'
LS_COLORS=$LS_COLORS:'*.ogm=01;35'
LS_COLORS=$LS_COLORS:'*.mp4=01;35'
LS_COLORS=$LS_COLORS:'*.m4v=01;35'
LS_COLORS=$LS_COLORS:'*.mp4v=01;35'
LS_COLORS=$LS_COLORS:'*.vob=01;35'
LS_COLORS=$LS_COLORS:'*.qt=01;35'
LS_COLORS=$LS_COLORS:'*.nuv=01;35'
LS_COLORS=$LS_COLORS:'*.wmv=01;35'
LS_COLORS=$LS_COLORS:'*.asf=01;35'
LS_COLORS=$LS_COLORS:'*.rm=01;35'
LS_COLORS=$LS_COLORS:'*.rmvb=01;35'
LS_COLORS=$LS_COLORS:'*.flc=01;35'
LS_COLORS=$LS_COLORS:'*.avi=01;35'
LS_COLORS=$LS_COLORS:'*.fli=01;35'
LS_COLORS=$LS_COLORS:'*.flv=01;35'
LS_COLORS=$LS_COLORS:'*.gl=01;35'
LS_COLORS=$LS_COLORS:'*.dl=01;35'
LS_COLORS=$LS_COLORS:'*.xcf=01;35'
LS_COLORS=$LS_COLORS:'*.xwd=01;35'
LS_COLORS=$LS_COLORS:'*.yuv=01;35'
LS_COLORS=$LS_COLORS:'*.cgm=01;35'
LS_COLORS=$LS_COLORS:'*.emf=01;35'
LS_COLORS=$LS_COLORS:'*.axv=01;35'
LS_COLORS=$LS_COLORS:'*.anx=01;35'
LS_COLORS=$LS_COLORS:'*.ogv=01;35'
LS_COLORS=$LS_COLORS:'*.ogx=01;35'
LS_COLORS=$LS_COLORS:'*.aac=00;36'
LS_COLORS=$LS_COLORS:'*.au=00;36'
LS_COLORS=$LS_COLORS:'*.flac=00;36'
LS_COLORS=$LS_COLORS:'*.m4a=00;36'
LS_COLORS=$LS_COLORS:'*.mid=00;36'
LS_COLORS=$LS_COLORS:'*.midi=00;36'
LS_COLORS=$LS_COLORS:'*.mka=00;36'
LS_COLORS=$LS_COLORS:'*.mp3=00;36'
LS_COLORS=$LS_COLORS:'*.mpc=00;36'
LS_COLORS=$LS_COLORS:'*.ogg=00;36'
LS_COLORS=$LS_COLORS:'*.ra=00;36'
LS_COLORS=$LS_COLORS:'*.wav=00;36'
LS_COLORS=$LS_COLORS:'*.axa=00;36'
LS_COLORS=$LS_COLORS:'*.oga=00;36'
LS_COLORS=$LS_COLORS:'*.spx=00;36'
LS_COLORS=$LS_COLORS:'*.xspf=00;36'

export LS_COLORS
clear

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /home/jameson/.travis/travis.sh ] && source /home/jameson/.travis/travis.sh
