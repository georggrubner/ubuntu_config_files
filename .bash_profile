alias nano="nano --smooth --constantshow --autoindent --softwrap"

##############################################################################
# 01. EXPORTS                                                                #
##############################################################################

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Make vim the default editor
export EDITOR="vim"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

##############################################################################
# 02. ALIASES                                                                #
##############################################################################

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias adverity="cd ~/projects/adverity;"
alias js="cd ~/projects/adverity/web-app/js; git status;"
alias dot="cd ~/.atom; git status;"

# Shortcuts
alias bashconf="sudo nano ~/.atom/.bash_profile"
alias loadbash="source ~/.atom/.bash_profile"

alias g="git"
alias gd="git checkout develop; git pull"

alias gdf="git diff"
alias gcdf="git diff --staged"
function gdfn { git diff HEAD~"$@" HEAD; }

alias gs="git status"
alias c="clear"
alias e="exit"
alias cgs="clear; git status"

function gadd {
  if [ -z $@ ]; then
    git add ~/projects/adverity/;
  else
    git add "$@";
  fi
  git status;
}

function ga {
  if [ -z $@ ]; then
    git add ~/projects/adverity/;
  else
    git add "$@";
  fi
  git status;
}


function gc { git commit -m "$@"; git status; }
function gcn { git commit -mn "$@"; git status; }
function discard {
  if [ -z $@ ]; then
    git checkout -- ~/projects/adverity/;
  else
    git checkout -- "$@";
  fi
  git status;
}
function cts {
  if [ -z $@ ]; then
    git reset --soft HEAD~1
  else
    git reset --soft HEAD~$@
  fi
  git status;
}
function to {
  branches=$(git branch --no-color | grep "$@")
  git checkout ${branches[0]};
  git pull;
}

# previous n branches or direct previous branch
function pb {
  if [ -z $@ ]; then
    git checkout @{-1}
  else
    git checkout @{-$@}
  fi
  git pull;
}

# show previous n branches or direct previous branch
function spb {
  if [ -z $@ ]; then
    git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | head -n1;
  else
    git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | awk ' !x[$0]++' | head -n$@;
  fi
}

function unstage {
  git reset HEAD "$@";
  git status;
}

alias branches="git branch"

alias jest="npm run test:jest:watch --"

alias gp="git push"
alias gmd="git merge develop"
alias gmu="gd;pb;gmd"
alias gitconf="nano ~/.gitconfig"

alias grailsstart="clear; cd ~/projects/adverity/; grails run-app -reloading"
alias npmstart="clear; cd ~/projects/adverity/web-app/; node server.js"
alias npmi="cd ~/projects/adverity/web-app/; npm i"
alias storybook="cd ~/projects/adverity/web-app/; npm run storybook"
# alias test="cd ~/projects/adverity/web-app/; npm run test:watch"

alias new="git flow feature start"
alias pull="git pull"
alias push="git push"
alias fetch="git fetch"
function cms { # last n commit messages
    git status;
    printf "\n"
    if [ -z $@ ]; then
        #git log -1 --pretty=format:"%h %an %s";
        git log -1 --pretty=format:"%h %s";
    else
        #git log -"$@" --pretty=format:"%h %an %s";
        git log -"$@" --pretty=format:"%h %s";
    fi
}

alias sh="history | grep"

function pop {
  if [ -z $@ ]; then
    git stash pop;
  else
    git stash pop stash@{$@};
  fi
}

function stash {
  git status;
  if [ -z $@ ]; then
    git stash;
  else
    git stash save "$@";
  fi
}
alias stashlist="git stash list"
function viewstash {
  if [ -z $@ ]; then
    git stash show -p;
  else
    git stash show -p stash@{$@};
  fi
}
function dropstash {
  if [ -z $@ ]; then
    git stash drop;
  else
    git stash drop stash@{$@};
  fi
}

alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

#work in progress
#function to {
#  branchList=($(git branch --list --no-color))
#  echo "${branchList[*]}"
#  for (( index=0; index<${#branchList[@]}; index++ ));
#  do
#    branchList[index]="${branchList[index]/\*/''}";
#  done
#  filteredBranches=($($branchList | grep --no-filename $@));
#  resultCount=$($filteredBranches | grep --no-filename -c $@);
#  echo "length: $resultCount";
#  if [ -z $filteredBranches ];
#  then
#    echo "no branches found";
#  else
#    if [ $resultCount -eq 1 ];
#    then
#      fixedBranchName="${${filteredBranches[0]}/\*/''}";
#      git checkout ${fixedBranchName};
#      git pull;
#    else
#      echo "found branches:";
#      for (( index=0; index<$resultCount; index++ ));
#      do
#        fixedBranchName="${${filteredBranches[index]}/\*/''}";
#        echo "$index: ${fixedBranchName}";
#      done;
#    fi;
#  fi;
#}

alias ll='ls -al'
alias l='less'
alias mv='mv -i'
alias cp='cp -i -p'
alias ls='ls -abp --color=auto'
alias grep='grep --color=auto'

# Color LS
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories


# Enable aliases to be sudo’ed
alias sudo='sudo '

# Gzip-enabled `curl`
alias gurl='curl --compressed'

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

##############################################################################
# 03. FUNCTIONS                                                              #
##############################################################################

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$@"
}

##############################################################################
# 04. PROMPT COLORS                                                          #
##############################################################################

# copied from https://github.com/mathiasbynens/dotfiles/

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
# PS1+="\t "; # time
PS1+="\[${userStyle}\]\u"; # username
#PS1+="\[${white}\] at ";
#PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\]@";
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${white}\] \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
#PS1+="\n";
PS1+="\[${white}\]: \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

##############################################################################
# 05. BASH                                                                   #
##############################################################################

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

##############################################################################
# 06. EXTRA                                                                  #
##############################################################################

[ -f ~/.extra ] && source ~/.extra

if [[ -a ~/.localrc ]]; then
    source ~/.localrc
fi

# Puts date in front of history of commands
HISTTIMEFORMAT="%d.%m.%Y %T "
