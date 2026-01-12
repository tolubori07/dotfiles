# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Set ZSH theme
# Uncomment to use Powerlevel10k if desired
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Keychain for SSH (moved before instant prompt)
# keychain id_rsa --agents ssh  

# Enable p10k-instant-prompt for faster ZSH load
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
# Command correction and completion settings
ENABLE_CORRECTION="true"           # Enable auto-correction
COMPLETION_WAITING_DOTS="true"     # Show dots during completion


# Preferred editor
export EDITOR='nvim'

# Aliases for Neovim configurations
alias chad="NVIM_APPNAME=NvChad nvim"
alias lvim='NVIM_APPNAME=lazyvim nvim'
alias avim='NVIM_APPNAME=astronvim nvim'
alias rvim='NVIM_APPNAME=rvim nvim'
alias pvim='NVIM_APPNAME=pvim nvim'
alias dvim='NVIM_APPNAME=dvim nvim'

# Useful aliases
alias ls="colorls"               # Colorized ls
alias rustk='rusty-krab-manager -c ~/.config/rusty-krab-manager/config.toml'
alias skullz="~/.config/skullz/skullz"
alias blocks="~/.config/blocks/blocks"
alias bang="~/.config/crunchbang/crunchbang"
alias pacman="~/.config/pacman/pacman"
alias kaisen="~/.config/kaisen"
alias bonk="~/coding/justcoding/clang/bonk/bonk"

# Automatically change to a directory by typing its name
setopt AUTOCD

# Path adjustments
export PATH="$HOME/.console-ninja/.bin:$HOME/go/bin/mdx:$BUN_INSTALL/bin:/usr/local/opt/ruby/bin:/usr/local/Cellar/llvm/19.1.4/bin:$PATH"
export PATH="$PATH:${HOME}/Library/Python/3.12/lib/python/site-packages"

export PATH="/Users/moshoodbello/.local/bin:$PATH"

# bun completions
[ -s "/Users/moshoodbello/.bun/_bun" ] && source "/Users/moshoodbello/.bun/_bun"

# Starship prompt
#eval "$(starship init zsh)"

# TheFuck alias
eval $(thefuck --alias)


# fzf setup
eval "$(fzf --zsh)"

# Pywal function
#function pywal {
  # Generate color scheme from current wallpaper
 # current_wallpaper="$(osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)')"
  #wal -i "$current_wallpaper" -n
#}
function pywal {
  current_wallpaper="$(osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)')"
  wal -i "$current_wallpaper" --backend colorz -n 2>/dev/null
 # ghosttywal
}


# Fastfetch (run conditionally outside SSH sessions)
if [[ $TERM_PROGRAM != "ssh" ]]; then
  fastfetch
fi

# Compilation flags
#export CXXFLAGS="-std=c++17"

# Uncomment and set to enable history timestamp
# HIST_STAMPS="mm/dd/yyyy"

# Uncomment to disable VCS untracked file checks for performance
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment to set custom language environment
# export LANG=en_US.UTF-8

# Uncomment and set for manual MANPATH configuration
# export MANPATH="/usr/local/man:$MANPATH"

# Uncomment to disable magic functions if pasting is an issue
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment to disable auto-setting terminal title
# DISABLE_AUTO_TITLE="true"

# Uncomment to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment for case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment for hyphen-insensitive completion
# HYPHEN_INSENSITIVE="true"

# Uncomment to enable instant-prompt configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/usr/local/Cellar/llvm/19.1.5/bin/llvm-config:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/Caskroom/redis-stack-server/7.4.0/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export PATH="$PATH:/usr/local/bin/zig"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PKG_CONFIG_PATH=$(brew --prefix gtk4)/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$(brew --prefix graphene)/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$(brew --prefix cairo)/lib/pkgconfig:$PKG_CONFIG_PATH
wallpaper () { automator -i "${1}" ~/wallchooser.workflow }
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/shell-color-scripts/colorscripts:$PATH"
eval "$(zoxide init zsh)"
figlet -f lean LYFE
. "/Users/moshoodbello/.deno/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


PATH=~/.console-ninja/.bin:$PATH
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
  fi
  export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

export PATH=$PATH:/Users/moshoodbello/.spicetify
export PATH=$PATH:/Users/moshoodbello/helix/bin
# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"


