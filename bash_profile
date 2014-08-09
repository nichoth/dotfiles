#colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#stuff for gdb
alias objcopy="gobjcopy"
alias objdump="gobjdump -M intel"

#shortcuts
alias sc='cd ~/Desktop/slow\ clouds/'
alias htdocs='cd /Applications/MAMP/htdocs/'
alias la='ls -a'
alias ll='ls -l'

#show hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'

#mkdir and then cd to the new dir
#longhand version for reference: mkdir -p "newdir" && cd "$_"
function md () { mkdir -p "$@" && cd "$@"; }

#copies the working path to the clipboard
alias cpwd="pwd | tr -d '\n' | pbcopy"

#add git auto-completion
source ~/.git-completion.bash

#add git branch to command prompt
source ~/.git-prompt.sh
#export PS1='\[\033[00m\]\W\[\[\033[38;5;214m\]$(__git_ps1 " (%s)")\[\033[00m\] \[\033[0;33m\]\u\[\033[00m\]$ '
export PS1='\[\033[0;33m\]\W\[\033[38;5;214m\]$(__git_ps1 "(%s)")\[\033[00m\]\[\033[00m\] \u\$ '
#export PS1='\W\[\033[38;5;214m\]$(__git_ps1 "(%s)")\[\033[00m\] \u\$ '

#for globbing
export GLOBIGNORE=.:..

#MAMP
alias mysql="/Applications/MAMP/Library/bin/mysql --host=localhost -uroot -proot"

##
# Use MAMP PHP on command line
##
echo $PATH | grep -q -s "/Applications/MAMP/bin/php/php5.5.10/bin"
if [ $? -eq 1 ] ; then
	export MAMP_PATH=/Applications/MAMP/bin/php/php5.5.10/bin
	export PATH="$MAMP_PATH:$PATH"
fi

# Add wp-cli auto completion
source ~/.wp-completion.bash

# z script
source ~/.z.sh

# for google app engine java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export M2_HOME=/usr/local/apache-maven/apache-maven-3.2.2
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
