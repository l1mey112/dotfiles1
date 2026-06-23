# node v22 spoof, only setting on PATH
set -l shim "$HOME/.local/libexec/nodespoof"
if not contains -- $shim $PATH
    set -gx PATH $shim $PATH
end
