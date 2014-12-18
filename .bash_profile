export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/bin:~/Code/scripts:/usr/local/go/bin

[[ -s /Users/mpeddle/.nvm/nvm.sh ]] && . /Users/mpeddle/.nvm/nvm.sh # This loads NVM

alias ll='ls -alt'
alias ge='grep -r '$1' . | grep -v test | grep -v migration'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


###---------------------------------------------------------------------------
### FUNCTIONS
###---------------------------------------------------------------------------

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function findpid {
    ps aux | grep $1 | awk '{print $2}'
}

function killmatch {
    pid=$1; shift
    findpid $pid | xargs kill "$@"
}

###---------------------------------------------------------------------------
### ALIASES
###---------------------------------------------------------------------------

alias cdm='cd /Users/mpeddle/Projects/modalyst/modalyst'

alias sudo='sudo '     # allows you to pass aliases to sudo
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# navigation aliases
alias ..='cd ..'              # change to the parent directory
alias ...='cd ../..'          # change to the grandparent directory
alias -- -="cd -"             # go to previous dir
#alias ls='ls --color=auto -p' # add color
alias l.='ls -d .*'           # list hidden files
alias ll='ls -lahrt'          # shortcut for ls with extra info
alias lld='ls -lUd */'        # list directories only

# Git Aliases
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gd='git diff | vi'
alias gf='git fetch'
alias gl='git log --decorate --graph --date-order'
alias gll='git log --oneline --graph --decorate --left-right --boundary --date-order'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote -v'
alias gs='git status'
alias gu='git up'

# Django/Python aliases
alias pipup='pip install --upgrade'
alias dj='python manage.py'
alias djr='python manage.py runserver_plus'
alias djs='python manage.py shell_plus'
alias djsp='workon hukkster; cdh; cd src/hukkster-django; python manage.py shell_plus'
alias djserver='workon hukkster; cdh; cd src/hukkster-django; djr 8101'
alias djhub='workon hukkster; cdh; cd src/hukkster-hub; djr 8102'

# Salt Aliases
alias saltme='sudo -E salt-call'
alias saltit='saltme state.sls '
alias devon='saltit packages.circus.dev_mode_on'
alias devoff='saltit packages.circus.dev_mode_off'
alias saltall='saltme state.highstate'
alias updatesaltmaster='ssh inf-saltmaster.hukkdev.com "cd /srv/deploy; sudo -E git pull"'

# system monitoring
#alias topcpu='ps aux | sort -n -k 2 | tail -10' # top 10 cpu processes
alias topcpu='top -o cpu'
alias topmem='ps aux | sort -b -k 4 | tail'
alias ispy='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
alias dush='du -sm * | sort -n | tail' # find megabyte eating files/directories
alias usingnet='lsof -P -i -n' # show all apps using the internet at the moment

###---------------------------------------------------------------------------
### Env
###---------------------------------------------------------------------------

# colorize Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

#source /home/mpeddle/.git_config_complete

# add color to the terminal
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # assumes black background
export CLICOLOR=1
export PS1='\W \u$ '

#xterm colors for vim
export TERM="xterm-256color"

# replace diff w/ colorizediff
#alias diff="colordiff"

# History configuration
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=erasedups

#modalyst config
alias cdmod='cd ~/Projects/modalyst/modalyst'
alias gomod='cdmod; source ../bin/activate'

#postgres
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

#alias memory_usage='ps -u $USER -o pcpu,rss | awk 'NR>1' | awk '\''{cpu += $1; rss += $2} END {print cpu, rss}'\'''

export NEW_RELIC_DISABLE='TRUE'
source ~/git-complete.bash
source ~/.profile
export GOPATH=$HOME/go
export GOROOT=/usr/local/go/bin/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/sbin 
