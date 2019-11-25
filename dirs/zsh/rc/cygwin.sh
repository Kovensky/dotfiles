
function _wrap_exe_if_exists() {
    if [[ -n "$1" ]]; then
        wrap_exe "$1"
    fi
}

function _wrap_exe_bg_if_exists() {
    if [[ -n "$1" ]]; then
        wrap_exe "$1" '&'
    fi
}

if [[ "$OSTYPE" =~ "cygwin" ]]; then
    _wrap_exe_if_exists /cygdrive/c/Program*/VideoLAN/VLC/vlc.exe(N)
    _wrap_exe_bg_if_exists /cygdrive/c/Program*/Sublime\ Text\ 3/sublime_text.exe(N)
    alias st=sublime_text

    ulimit -c 0

    export CYGWIN="$CYGWIN nodosfilewarning proc_retry:2"
    export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
fi
