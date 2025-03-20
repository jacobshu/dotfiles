# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig='nvim ~/.zshrc'
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias dontbestupid='open -n /Applications/Visual\ Studio.app/Contents/MacOS/VisualStudio'
alias dot='cd ~/dev/dotfiles'
alias dev='cd ~/dev'
alias up='brew upgrade'
alias love='/Applications/love.app/Contents/MacOS/love'
alias l='lsd -lh'
alias ll='lsd -lah'
alias rise='dot && git pull && brew upgrade'

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
    mode=$1
    if [[ $mode == "ssh" ]]; then
      if [[ $# -gt 4 || $# -lt 4 ]]; then
          echo "Usage: vimme ssh [connection string]"
          echo "       vimme ssh installname@22.222.222.222 -p 12345"
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

    elif [[ $mode == "vps" ]]; then 
      if [[ $# -gt 2 || $# -lt 2 ]]; then
        echo "Usage: vimme vps [username@server]"
        echo "       vimme vps username@22.222.222.222"
        return 1
      fi

      name_and_ip=$2

      array=("${(@s:@:)name_and_ip}")
      name=${array[1]}
      ip=${array[2]}

      echo "name: ${name}"
      echo "ip  : ${ip}"

      # distribute ghostty's terminfo
      infocmp -x | ssh $name_and_ip -- tic -x -

      rsync -vzhr $HOME/dev/dotfiles/nvim $name@$ip:.config/

    fi

    echo "Usage: vimme mode [connection string]"
    echo "       vimme ssh installname@22.222.222.222 -p 12345"
    echo "       vimme vps username@22.222.222.222"
    return 1

}

# config for op gh
source /Users/jacobshu/.config/op/plugins.sh

# env variables
export ANTHROPIC_API_KEY=op://Employee/Anthropic/credentials/personal_token

eval "$(starship init zsh)"
