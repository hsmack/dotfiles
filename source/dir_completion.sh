# Completions
_my_dirs() {
  local comp=${COMP_WORDS[COMP_CWORD]}
  if [[ "$comp" != /* && "$comp" != .* && "$comp" != ~* && $(cd "${comp%/*}" 2>/dev/null && pwd && cd "$OLDPWD") != "$HOME/Documents" ]]; then
    COMPREPLY=($(ruby -e 'comp, pwd, docs = [ARGV.shift] + ARGV.map { |a| a.split }; puts docs.reject { |d| pwd.any? { |p| p =~ %r{#{Regexp.escape(comp)}[^/]*\Z} } }' "${COMP_WORDS[COMP_CWORD]##*/}" "$(ls -d `pwd`/"${COMP_WORDS[COMP_CWORD]##*/}"* 2>/dev/null)" "$(ls -d ~/Documents/"${COMP_WORDS[COMP_CWORD]##*/}"* 2>/dev/null)"))
  fi
}
complete -F _my_dirs -o plusdirs cd

