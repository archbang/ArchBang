[ -z "$PS1" ] && return
#PS1='[\u@\h \W]\$ '
PS1="\e[01;31m┌─[\e[01;35m\u\e[01;31m]──[\e[00;37m${HOSTNAME%%.*}\e[01;32m]:\w$\e[01;31m\n\e[01;31m└──\e[01;36m>>\e[00m"
alias ls='ls --color=auto'
cat ~/.logo
echo
date
