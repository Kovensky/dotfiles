zplugin ice depth=1 nocd
zplugin light romkatv/powerlevel10k

zplugin ice as='completion' \
  atclone="chmod +x ./rustup-init.sh && ./rustup-init.sh -v -y --default-toolchain none && ${(q)USERPROFILE:-$HOME}/.cargo/bin/rustup completions zsh > ./_rustup" \
  atpull='%atclone' \
  atload='if [[ -f "$HOME/.cargo/env" ]]; then source "$HOME/.cargo/env"; fi'
zplugin snippet 'https://github.com/rust-lang/rustup/blob/master/rustup-init.sh'

zplugin ice lucid atclone='"${commands[dircolors]:-$commands[gdircolors]}" -b LS_COLORS > clrs.zsh' \
    atpull='%atclone' pick='clrs.zsh' nocompile'!' \
    atload='zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
    if='[[ -n "${commands[dircolors]:-$commands[gdircolors]}" ]]'
zplugin light trapd00r/LS_COLORS

zplugin ice lucid wait blockf atpull='zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice as='completion' mv='_mpv.zsh -> _mpv'
zplugin snippet 'https://github.com/mpv-player/mpv/blob/master/etc/_mpv.zsh'

COMPLETION_WAITING_DOTS=true
zplugin ice depth='1' as'null' nocd \
    multisrc='lib/{completion,key-bindings,compfix,functions,termsupport}.zsh' \
    atload='![[ "${(%):-%#}" != "#" ]] && handle_completion_insecurities'
zplugin load robbyrussell/oh-my-zsh

if [[ "${(%):-%#}" != "#" ]]; then
    # only if not root
    zstyle :omz:plugins:ssh-agent agent-forwarding on
    [[ -e "$HOME/.ssh/id_ed25519" ]] && zstyle :omz:plugins:ssh-agent identities id_ed25519
    zplugin ice silent
    zplugin snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
fi

if [[ -e "$HOME/.homesick/repos/homeshick/completions/_homeshick" ]]; then
    zplugin ice lucid as='completion'
    zplugin snippet "$HOME/.homesick/repos/homeshick/completions/_homeshick"
fi

zplugin ice lucid wait atload='_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

# must be last
zplugin ice lucid wait atinit='ZPLGM[COMPINIT_OPTS]=-i; zpcompinit; zpcdreplay'
zplugin light zdharma/fast-syntax-highlighting
