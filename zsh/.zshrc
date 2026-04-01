# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd

autoload -U compinit && compinit

source ~/.config/shell/alias

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# set up prompt
NEWLINE=$'\n'
PROMPT="${NEWLINE} %K{#080808}%F{#ffffff}$(date +%_H:%M) %K{#d9396a}%F{#ffffff} %n %K{#080808} %~ %f%k ❯ " # baba theme
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

echo -e "${NEWLINE} \x1b[1m\x1b[38;5;15m\x1b[48;5;198m$TERM\x1b[0m IS \x1b[1m\x1b[38;5;15m\x1b[48;5;198mYOU \x1b[0m \n ANSI escape currently incorrect :("

# custom functions
# cd_to_dir is no longer necessary, press ALT+C for completion

# fzf
# [ -f ~/.config/shell/fzfrc ] && source ~/.config/shell/fzfrc
source <(fzf --zsh)

# z
. ~/scripts/.z.sh
unalias z 2> /dev/null
z() {
  local dir=$(
    _z 2>&1 |
    fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --accept-nth 2..
  ) && cd "$dir"
}

# autosuggestions
# requires zsh-autosuggestions
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# managing dotfiles
source /usr/share/zsh/plugins/dotbare/dotbare.plugin.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
