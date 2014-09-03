# ssh Completions
_my_hosts() {
  local comp=${COMP_WORDS[COMP_CWORD]}
  if [[ "$comp" == *:/* && "$1" == *scp ]]; then
    local path=${comp#*:}
    COMPREPLY=($(compgen -W "$(ssh "${comp%%:*}" ls -FHd "${path}*" 2>/dev/null | sed 's/[*@=%|]$//')" -- "${path}"))
  else
    COMPREPLY=($(compgen -W "$(ruby -ne 'print $1, " " if /\AHost\s+(\S+)/' ~/.ssh/config)" -- "$comp"))
  fi
}
complete -F _my_hosts -o nospace -o default ssh scp
