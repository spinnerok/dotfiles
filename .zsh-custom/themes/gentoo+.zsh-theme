autoload -Uz colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{green}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '%F{5}(%F{2}%b%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:*' formats '%F{yellow}%b%c%u%m%f '
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%F{5}(%F{2}%b%F{1}:%{3}%i%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:svn:*' formats '%F{5}(%F{2}%b%F{1}:%F{3}%i%c%u%m%F{5})%f '
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:git*+set-message:*' hooks untracked-git

+vi-untracked-git() {
  if command git status --porcelain 2>/dev/null | command grep -q '??'; then
    hook_com[misc]='%F{red}?'
  else
    hook_com[misc]=''
  fi
}

gentoo_precmd() {
  vcs_info
}

autoload -U add-zsh-hook
add-zsh-hook precmd gentoo_precmd

# %(!.A.B) means: if root user, use A; otherwise use B.
# %F{color} sets foreground color, %f resets it.
# %1~ is current dir shortened to last segment.
# %~ is current dir with ~ for home (full relative path).
# ${vcs_info_msg_0_} inserts git/svn branch/status text populated by vcs_info.
# %(!.#.$) shows # for root, $ for normal user.
# %k resets background color.

PROMPT='%(!.%{$fg_bold[red]%}.%{$FG[008]%})%(!.%1~.%~) ${vcs_info_msg_0_}%(!.%{$fg_bold[red]%}.%{$FG[008]%})%(!.#.$)%k%b%f '
