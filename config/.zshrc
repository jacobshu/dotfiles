# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias dontbestupid='open -n /Applications/Visual\ Studio.app/Contents/MacOS/VisualStudio'
alias dot='cd ~/dev/dotfiles'
alias dev='cd ~/dev'
alias up='brew upgrade'
alias love="/Applications/love.app/Contents/MacOS/love"

# Utility functions
woffer () {
  for file in $2/*.$1; do 
    [ -f "$file" ] || continue
    woff2_compress $file; 
  done
  mkdir $2/woff
  for file in $2/*.woff2; do mv $file $2/woff; done
}

follow () {
  curl -s -L -D - "$1" -o /dev/null -w '%{url_effective}'
}

onPort () {
  lsof -nP -iTCP -sTCP:LISTEN | grep $1
}

run () {
  project=~/dev/dotfiles/scripts/$1.sh
  echo "Running $project"
  sh $project "${@:2}"
}

vimme() {
    # Check if minimum required arguments are provided
    if [[ $# -gt 4 || $# -lt 4 ]]; then
        echo "Usage: vimme [connection string]"
        echo "Example: vimme ssh installname@22.222.222.222 -p 12345"
        return 1
    fi

    name_and_ip=$2
    port=$4

    array=("${(@s:@:)name_and_ip}")
    name=${array[1]}
    ip=${array[2]}

    echo "name: ${name}"
    echo "ip  : ${ip}"
    echo "port: ${port}"

    port_option="ssh -p ${port}"
    # distribute ghostty's terminfo
    infocmp -x | ssh $name_and_ip -p $port -- tic -x -

    rsync -vzh -e "${port_option}" $HOME/dev/dotfiles/config/.vimrc $name@$ip:
}

# env variables
export ANTHROPIC_API_KEY=op://Employee/Anthropic/credentials/personal_token

eval "$(starship init zsh)"
