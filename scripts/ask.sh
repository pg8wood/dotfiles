# https://gist.github.com/davejamesmiller/1965569 <3
ask() {
  local prompt default reply

  if [[ ${2:-} = 'Y' ]]; then
      prompt='Y/n'
      default='Y'
  elif [[ ${2:-} = 'N' ]]; then
      prompt='y/N'
      default='N'
  else
      prompt='y/n'
      default=''
  fi

  while true; do

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    printf "$1 [$prompt]\n"

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read -r reply </dev/tty

    # Default?
    if [[ -z $reply ]]; then
        reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
        Y*|y*) return 0 ;;
        N*|n*) return 1 ;;
    esac

  done
}
