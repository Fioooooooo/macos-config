# HomeBrew
export HOMEBREW_PIP_INDEX_URL=https://mirrors.cloud.tencent.com/pypi/simple #ckbrew
export HOMEBREW_API_DOMAIN=https://mirrors.cloud.tencent.com/homebrew-bottles/api  #ckbrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.cloud.tencent.com/homebrew-bottles #ckbrew
if [[ $(uname -m) == "arm64" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv) #ckbrew
else
  eval $(/usr/local/Homebrew/bin/brew shellenv) #ckbrew
fi

# JetBrains
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
