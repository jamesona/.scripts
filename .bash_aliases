alias ll='ls -lah'
alias r='source ~/.bashrc;reset'
alias ip="wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]|.]//g'"
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
alias vssh="vagrant ssh $@"