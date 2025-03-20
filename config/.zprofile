# relocate zsh & friends
export ZDOTDIR=$HOME/.config/zsh

# setup homebrew
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# setup flutter
export GOOGLE_APPLICATION_CREDENTIALS=/Users/jacobshu/dev/bn-modern/SwmServerTests/gv.json
export PATH="$PATH:$HOME/flutter/bin"
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

#postgres
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# golang packages
export PATH="$HOME/go/bin:$PATH"

# setup for android development
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools=

# pnpm
export PNPM_HOME="/Users/jacobshu/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export EDITOR=nvim
