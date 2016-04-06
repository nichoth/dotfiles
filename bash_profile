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
alias htdocs='cd /Applications/MAMP/htdocs/'
alias dot="cd ${HOME}/.dotfiles"

# ls
alias la='ls -a'
alias ll='ls -lh'
#alias ls='ls -F' # show trailing slashes on directories
alias lh='ls -d .??*' # show only hidden files
# `brew install coreutils` -- gls command
lsp() {
  gls --color=always "$@" | less -R;
}

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# digitalocean
alias sshdo="ssh nick@104.131.159.55"

# tree
alias tree='tree -C --dirsfirst'

# create github repo with description from package.json
hub() {
    if [[ $@ == "create" ]]; then
        command hub create -d "$(package-field description -s)" \
          -h "$(package-field homepage -s)"
    else
        command hub "$@"
    fi
}

# diff
# alias diff='/usr/bin/diff -u'

# Mac OS version
alias vers='sw_vers'

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

# copy the working path to the clipboard
alias cpwd="pwd | tr -d '\n' | pbcopy"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

#MAMP
alias mysql="/Applications/MAMP/Library/bin/mysql --host=localhost -uroot -proot"

# For github jekyll
# Run this in the github pages dir and it will serve at localhost:4000.
alias gityll="bundle exec jekyll serve"

# gibo (gitignore tool)
# for JS modules
alias gibojs="gibo SublimeText OSX Node Sass >> .gitignore && echo "bundle.js" >> .gitignore"

# pipe to base64 encode image and print to stdout
alias base64="openssl base64 | tr -d '\n'"

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
#alias catnpm="cat ~/.dotfiles/example-package.json"
alias cattar="echo https://github.com/nichoth/repo/tarball/master"
alias catserver="cat ~/.dotfiles/server.js"
alias catss="cat ~/.dotfiles/simple-server.js"
alias cathtml="cat ~/.dotfiles/_index.html"
alias catsass="cat ~/.dotfiles/_node-sass.js"
alias mul="echo ×"
alias pkg="echo \"{}\" >> package.json"
alias svg="cat ~/.dotfiles/_svg.template"

alias npmpp="npm version patch && npm publish"

# pretty date
alias datep="date +\"%m-%d-%y\""

# minify images
alias minpng="imagemin --plugin pngquant"

# Functions
# ______________________________________________________________________________

# publish to gh pages. If it's rejected, do this:
#     git push origin `git subtree split --prefix build_folder master`:gh-pages --force
# ex: ghpages public
function ghpages() {
  if [ -z "$1" ]
  then
    echo "Which folder do you want to deploy to GitHub Pages?"
    exit 1
  fi
  git subtree push --prefix $1 origin gh-pages
}

# demo ./example/index.html
function demo() {
    DEMO_DIR=${2-${PWD##*/}}  # use arg 2 or cwd name
    DEMO_PATH="$HOME/code/demos/public/$DEMO_DIR"
    mkdir -p $DEMO_PATH
    html-inline "$1" > "$DEMO_PATH/index.html" && \
    surge ~/code/demos/public &> /dev/null
    echo http://$(cat ~/code/demos/public/CNAME)/$DEMO_DIR
}

function pflix() {
    peerflix "$@" -f ~/Downloads/peerflix -a
}

# preview a markdown file
function mdp() {
  cat "$@" | vmd
}

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

# z script
source ~/.z.sh

export PATH=$PATH:~/bin
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

case $- in
   *i*) source ~/.bashrc
esac

# for go
export PATH=$PATH:/usr/local/go/bin
