alias ll='ls -lah'
alias r='source ~/.bashrc;reset'
alias ip="wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]|.]//g'"
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
alias vssh="vagrant ssh $@"
alias clean-local="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias ngt="ng t --code-coverage"


# Add sublime to Windows path
if ! [[ $(type -P subl) ]]; then
	if [[ $(type -P "/c/Program Files/Sublime Text 3/subl.exe") ]]; then
		alias subl="/c/Program\ Files/Sublime\ Text\ 3/subl.exe"
	fi
fi
