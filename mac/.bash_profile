eval "$(/opt/homebrew/bin/brew shellenv)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

export PATH="/Users/tuan882612/.local/bin:$PATH"

# Load pyenv-virtualenv automatically by adding
# the following to your profile
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tuan882612/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tuan882612/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/tuan882612/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tuan882612/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/tuan882612/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/tuan882612/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<