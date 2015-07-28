# https://github.com/mathiasbynens/dotfiles

#colors
#
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced




# Aliases
# ______________________________________________________________________________

#stuff for gdb
alias objcopy="gobjcopy"
alias objdump="gobjdump -M intel"

#shortcuts
alias cnc='cd ~/Desktop/fall-2014/'
alias htdocs='cd /Applications/MAMP/htdocs/'
alias dot="cd ${HOME}/.dotfiles"
alias spref="cd /Users/nick/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"

# ls
alias la='ls -a'
alias ll='ls -l'
#alias ls='ls -F' # show trailing slashes on directories
alias lh='ls -d .??*' # show only hidden files

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# tree
alias tree='tree -C --dirsfirst'

# create github repo with description from package.json
hub() {
    if [[ $@ == "create" ]]; then
        command hub create -d "$(package-field description -s)"
    else
        command hub "$@"
    fi
}

# diff
# alias diff='/usr/bin/diff -u'

# ssh to ada
alias ada='ssh thonic29@ada.evergreen.edu'
function scpada () {
	scp "$@" thonic29@ada.evergreen.edu:;
}

# function diff {
#    /usr/bin/diff -u "$@" | colordiff;
# }


# Easier navigation: .., ..., ...., .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# my notes on bash
alias examples="cat ${HOME}/.dotfiles/bash_examples.sh"
alias code="cd ~/code"

#show hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'

# ftp server
alias startftp='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
alias stopftp='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

#copies the working path to the clipboard
alias cpwd="pwd | tr -d '\n' | pbcopy"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

#MAMP
alias mysql="/Applications/MAMP/Library/bin/mysql --host=localhost -uroot -proot"

# For github jekyll
# Run this in the github pages dir and it will serve at localhost:4000.
alias gityll="bundle exec jekyll serve"

# Ember
alias em="ember"

# gibo (gitignore tool)
# for JS modules
alias gibojs="gibo SublimeText OSX Node Sass >> .gitignore && cat ~/.dotfiles/gitignore-node >> .gitignore"

# Use local gulp instead of global
# alias gulp='node_modules/.bin/gulp'

# copy and paste
alias pbp="pbpaste"
alias pbc="pbcopy"

# Markdown table of contents generator
alias mdtoc="gh-md-toc"

# set npm default semver range. Tilde:  ~1.2.3 means 1.2.x, with x > 3.
# Carat: ^1.2.3 means 1.x.y where x > 2, y > 3.
alias npmtilde="npm config set save-prefix='~'"
alias npmcarat="npm config set save-prefix='^'"

# package.json templates
alias catnpm="cat ~/.dotfiles/example-package.json"
alias catsass="cat ~/.dotfiles/sass-tasks"
alias cattar="cat ~/.dotfiles/gh-tarball"
alias catserver="cat ~/.dotfiles/server.js"
alias catss="cat ~/.dotfiles/simple-server.js"
alias cathtml="cat ~/.dotfiles/_index.html"

# download wordpress to current dir
alias wpinstall="curl https://wordpress.org/latest.tar.gz | tar --strip-components=1 -zxf- -C ."

function demo() {
    html-inline "$@" | \
    curl -sT- https://htmlb.in
}

# Functions
# ______________________________________________________________________________

# mkdir and then cd to the new dir
# longhand version for reference: mkdir -p "newdir" && cd "$_"
function md () { mkdir -p "$@" && cd "$@"; }

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function pjson() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
  else # pipe
    python -mjson.tool | pygmentize -l javascript;
  fi;
}


# `stree` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function stree() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}





# Config
# ______________________________________________________________________________

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

#add git auto-completion
source ~/.git-completion.bash

#add git branch to command prompt
source ~/.git-prompt.sh

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Make vim the default editor
export EDITOR="vim";

# Prompt
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BRIGHTYELLOW="\[\033[38;5;214m\]"

#export PS1='\[\033[00m\]\W\[\[\033[38;5;214m\]$(__git_ps1 " (%s)")\[\033[00m\] \[\033[0;33m\]\u\[\033[00m\]$ '

export PS1='\[\033[0;33m\]\W\[\033[38;5;214m\]$(__git_ps1 "(%s)")\[\033[00m\] \u\$ '

#export PS1='\W\[\033[38;5;214m\]$(__git_ps1 "(%s)")\[\033[00m\] \u\$ '

#for globbing
export GLOBIGNORE=.:..

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# postgres stuff
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

export PATH=$PATH:~/bin
