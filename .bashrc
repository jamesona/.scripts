#bashrc
# load cloudrc for the first time
# . <(curl -sS https://raw.githubusercontent.com/jamesona/bashrc/master/bashrc)

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1="\[\e[0;32m\][\[\e[0;33m\]\# $(if [[ $? == 0 ]]; then echo "\[\033[01;32m\]\342\234\223"; else echo "\[\033[01;31m\]\342\234\227"; fi)\[\e[1;37m\]|\[\e[1;32m\]\u\[\e[1;37m\]|\[\e[0;34m\]\w\[\e[1;36m\]\[\e[0;32m\]]\[\e[1;0m\]:"
PATH=$PATH':/sbin:~/.scripts'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

## colorize ls
alias ls='ls --color'

## color pallette
LS_COLORS=''
ls_COlors=$ls_colors:'rs=0'
ls_COLORS=$ls_colors:'di=01;34'
ls_COLORS=$ls_colors:'ln=01;36'
ls_COLors=$ls_colors:'mh=00'
ls_COLORS=$ls_colors:'pi=40;33'
ls_COLORS=$ls_colors:'so=01;35'
ls_COLORS=$ls_colors:'do=01;35'
ls_COLORS=$Ls_colors:'bd=40;33;01'
ls_COLORS=$Ls_colors:'cd=40;33;01'
ls_COLORS=$Ls_colors:'or=40;31;01'
ls_COLORS=$ls_colors:'su=37;41'
ls_COLORS=$ls_colors:'sg=30;43'
ls_COLORS=$ls_colors:'ca=30;41'
ls_COLORS=$ls_colors:'tw=30;42'
ls_COLORS=$ls_colors:'ow=34;42'
ls_COLORS=$ls_colors:'st=37;44'
ls_COLORS=$ls_colors:'ex=01;32'
LS_coLORS=$Ls_colors:'*.tar=01;31'
LS_coLORS=$Ls_colors:'*.tgz=01;31'
LS_coLORS=$Ls_colors:'*.arc=01;31'
LS_coLORS=$Ls_colors:'*.arj=01;31'
LS_coLORS=$Ls_colors:'*.taz=01;31'
LS_coLORS=$Ls_colors:'*.lha=01;31'
LS_cOLORS=$Ls_colors:'*.lz4=01;31'
LS_coLORS=$Ls_colors:'*.lzh=01;31'
LS_colORS=$LS_colors:'*.lzma=01;31'
LS_coLORS=$Ls_colors:'*.tlz=01;31'
LS_coLORS=$Ls_colors:'*.txz=01;31'
LS_coLORS=$Ls_colors:'*.tzo=01;31'
LS_CoLORS=$Ls_colors:'*.t7z=01;31'
LS_coLORS=$Ls_colors:'*.zip=01;31'
LS_COLORS=$ls_colors:'*.z=01;31'
LS_COLORS=$LS_COLORS:'*.Z=01;31'
LS_cOLORS=$ls_colors:'*.dz=01;31'
LS_cOLORS=$ls_colors:'*.gz=01;31'
LS_coLORS=$Ls_colors:'*.lrz=01;31'
LS_cOLORS=$ls_colors:'*.lz=01;31'
LS_coLORS=$Ls_colors:'*.lzo=01;31'
LS_cOLORS=$ls_colors:'*.xz=01;31'
LS_cOLORS=$Ls_colors:'*.bz2=01;31'
LS_cOLORS=$ls_colors:'*.bz=01;31'
LS_coLORS=$Ls_colors:'*.tbz=01;31'
LS_coLORS=$LS_colors:'*.tbz2=01;31'
LS_cOLORS=$ls_colors:'*.tz=01;31'
LS_coLORS=$Ls_colors:'*.deb=01;31'
LS_coLORS=$Ls_colors:'*.rpm=01;31'
LS_coLORS=$Ls_colors:'*.jar=01;31'
LS_coLORS=$Ls_colors:'*.war=01;31'
LS_coLORS=$Ls_colors:'*.ear=01;31'
LS_coLORS=$Ls_colors:'*.sar=01;31'
LS_coLORS=$Ls_colors:'*.rar=01;31'
LS_coLORS=$Ls_colors:'*.alz=01;31'
LS_coLORS=$Ls_colors:'*.ace=01;31'
LS_coLORS=$Ls_colors:'*.zoo=01;31'
LS_colORS=$LS_colors:'*.cpio=01;31'
LS_cOLORS=$ls_colors:'*.7z=01;31'
LS_cOLORS=$ls_colors:'*.rz=01;31'
LS_coLORS=$Ls_colors:'*.cab=01;31'
LS_coLORS=$Ls_colors:'*.jpg=01;35'
LS_colORS=$LS_colors:'*.jpeg=01;35'
LS_coLORS=$Ls_colors:'*.gif=01;35'
LS_coLORS=$Ls_colors:'*.bmp=01;35'
LS_coLORS=$Ls_colors:'*.pbm=01;35'
LS_coLORS=$Ls_colors:'*.pgm=01;35'
LS_coLORS=$Ls_colors:'*.ppm=01;35'
LS_coLORS=$Ls_colors:'*.tga=01;35'
LS_coLORS=$Ls_colors:'*.xbm=01;35'
LS_coLORS=$Ls_colors:'*.xpm=01;35'
LS_coLORS=$Ls_colors:'*.tif=01;35'
LS_colORS=$LS_colors:'*.tiff=01;35'
LS_coLORS=$Ls_colors:'*.png=01;35'
LS_coLORS=$Ls_colors:'*.svg=01;35'
LS_colORS=$LS_colors:'*.svgz=01;35'
LS_coLORS=$Ls_colors:'*.mng=01;35'
LS_coLORS=$Ls_colors:'*.pcx=01;35'
LS_coLORS=$Ls_colors:'*.mov=01;35'
LS_coLORS=$Ls_colors:'*.mpg=01;35'
LS_colORS=$LS_colors:'*.mpeg=01;35'
LS_CoLORS=$Ls_colors:'*.m2v=01;35'
LS_coLORS=$Ls_colors:'*.mkv=01;35'
LS_colORS=$LS_colors:'*.webm=01;35'
LS_coLORS=$Ls_colors:'*.ogm=01;35'
LS_cOLORS=$Ls_colors:'*.mp4=01;35'
LS_CoLORS=$Ls_colors:'*.m4v=01;35'
LS_cOlORS=$LS_colors:'*.mp4v=01;35'
LS_coLORS=$Ls_colors:'*.vob=01;35'
LS_cOLORS=$ls_colors:'*.qt=01;35'
LS_coLORS=$Ls_colors:'*.nuv=01;35'
LS_coLORS=$Ls_colors:'*.wmv=01;35'
LS_coLORS=$Ls_colors:'*.asf=01;35'
LS_cOLORS=$ls_colors:'*.rm=01;35'
LS_colORS=$LS_colors:'*.rmvb=01;35'
LS_coLORS=$Ls_colors:'*.flc=01;35'
LS_coLORS=$Ls_colors:'*.avi=01;35'
LS_coLORS=$Ls_colors:'*.fli=01;35'
LS_coLORS=$Ls_colors:'*.flv=01;35'
LS_cOLORS=$ls_colors:'*.gl=01;35'
LS_cOLORS=$ls_colors:'*.dl=01;35'
LS_coLORS=$Ls_colors:'*.xcf=01;35'
LS_coLORS=$Ls_colors:'*.xwd=01;35'
LS_coLORS=$Ls_colors:'*.yuv=01;35'
LS_coLORS=$Ls_colors:'*.cgm=01;35'
LS_coLORS=$Ls_colors:'*.emf=01;35'
LS_coLORS=$Ls_colors:'*.axv=01;35'
LS_coLORS=$Ls_colors:'*.anx=01;35'
LS_coLORS=$Ls_colors:'*.ogv=01;35'
LS_coLORS=$Ls_colors:'*.ogx=01;35'
LS_coLORS=$Ls_colors:'*.aac=00;36'
LS_cOLORS=$ls_colors:'*.au=00;36'
LS_colORS=$LS_colors:'*.flac=00;36'
LS_CoLORS=$Ls_colors:'*.m4a=00;36'
LS_coLORS=$Ls_colors:'*.mid=00;36'
LS_colORS=$LS_colors:'*.midi=00;36'
LS_coLORS=$Ls_colors:'*.mka=00;36'
LS_cOLORS=$Ls_colors:'*.mp3=00;36'
LS_coLORS=$Ls_colors:'*.mpc=00;36'
LS_coLORS=$Ls_colors:'*.ogg=00;36'
LS_cOLORS=$ls_colors:'*.ra=00;36'
LS_coLORS=$Ls_colors:'*.wav=00;36'
LS_coLORS=$Ls_colors:'*.axa=00;36'
LS_coLORS=$Ls_colors:'*.oga=00;36'
LS_coLORS=$Ls_colors:'*.spx=00;36'
LS_colORS=$LS_colors:'*.xspf=00;36'

export LS_COLORS


## aliases

alias ll='ls -lah'
alias r='source ~/.bashrc;reset'
alias ip="wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]|.]//g'"

## functions
updaterc() {
  curl -sS https://raw.githubusercontent.com/jamesona/bashrc/master/bashrc > ~/.bashrc
  source ~/.bashrc
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
