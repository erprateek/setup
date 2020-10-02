alias ll='ls -l';
alias lll='ls -ltra';
alias lld='ls -ld'
alias lesss='less -S';
alias luster='ls -ltrSah'
alias llwcl='ls -l | wc -l'
alias myps='ps -efl | grep $USER'

alias emasc='emacs'

## Multi-sessions
alias sr='screen -r';
alias ss='screen -S';
alias sl='screen -list';

## HPC Aliases
alias qs='watch -n10 "qstat -xml | tr '\''\n'\'' '\'' '\'' | sed '\''s#<job_list[^>]*>#\n#g'\'' | sed '\''s#<[^>]*>##g'\'' | grep '\'' '\'' | column -t"';
alias myjobs='qstat | cut -d " " -f 10 | sort | uniq -c | grep "[qw|r|t]"'

## Git aliases
alias glp='git log -p'
alias glpo='git log --pretty=oneline'
alias got='git'
alias grr='git remote get-url origin'

## python specific
alias lnotebook='jupyter lab --no-browser --ip=$(hostname --fqdn)'

### Functions

# Get non empty files in current directory
function ne() { find . -type f -not -empty -ls; }
function mkcd { mkdir -p  $1; cd $1; }
function tailer { tail -500 $1 | less }

# Compress but original intact
gzipkeep() { 
    if [ -f "$1" ] ; then
        gzip -c -- "$1" > "$1.gz"
    fi
}

# Show 1-line header when using grep
function greph {
    p=$1;
    f=$2;
    head -50 $f | grep -v "##" | head -1;
    egrep $p $f;
}

# Show column indices for files with 1 line header and large number of columns
function show_col_num { head -1 $1 | sed 's/\t/\n/g' | nl }

# Cleanup unwanted files generated as a part of regular work
function clean() {
    rm -rf *.pyc
    rm -rf *~
    rm -rf *.pe*
    rm -rf *.po*
    rm -rf *.sh.o*
    rm -rf *.sh.e*
}

### VCF Files
function getvars() {
    grep -v "#" $1
}

function varct() {
    vcf_file=$1
    getvars $vcf_file | wc -l
}


### Bash prompt

export PROMPT_DIRTRIM=2
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="[\[\033[00;33m\]\$(date +%d%b) \$(date +%T) \[\033[01;34m\]\h \[\033[00;32m\]\w \[\033[01;36m\]\${timer_show}s\[\033[00m\]]\$(parse_git_branc\h)\[\033[00m\]$ "
force_color_prompt=yes
# have bash prompt show time of command
function timer_start {
 timer=${timer:-$SECONDS}
}
function timer_stop {
 timer_show=$(($SECONDS - $timer))
 unset timer
}
trap 'timer_start' DEBUG
export PROMPT_COMMAND=timer_stop

## Make sure terminal views are ok when resized
shopt -s checkwinsize

# TLDR customization
export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='green'
export TLDR_CODE='red'
export TLDR_PARAM='blue'
complete -W "$(tldr 2>/dev/null --list)" tldr
