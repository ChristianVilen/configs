alias ll="ls -al"
alias l="ls -al"
alias dc="docker-compose"
alias ..="cd .."
alias vim=nvim
alias g=git

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f "/Users/christian.vilen/.ghcup/env" ] && source "/Users/christian.vilen/.ghcup/env" # ghcup-env

# find_port
#
# Finds the port that's keeping your port as a hostage
#
# Usage:
# find_port 5000
#
function find_port() {
  lsof -nP "-iTCP:$1" | grep LISTEN
}

# monday
#
# Manually run repetitive tasks (like installing updates). Should be ran on
# every Monday.

function monday() {
  # Upgrade everything
  brew upgrade                  # Upgraade most Homebrew packages
  brew upgrade --cask --greedy  # Upgrade apps that have auto-update feature
  softwareupdate -ia            # Mac's own software update
  mas upgrade                   # Programmatic App Store update

  # Remove old versions from the cellar
  brew cleanup

  # Clean docker
  DOCKER_RUNNING=$(docker info 2>/dev/null | grep -c running)
  if [ "$DOCKER_RUNNING" -gt 0 ]; then
    yes | docker image prune
    yes | docker container prune
    yes | docker volume prune
    yes | docker system prune
  fi
}

# pingsay
#
# Privides an audible cue about the system being online or not
#
function pingsay() {
  ping 8.8.8.8 2>/dev/null | sed -l 's/.*bytes.*/yay/; s/.*timeout.*/nah/' | xargs -I {} say {}
}
