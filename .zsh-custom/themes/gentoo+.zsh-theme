function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

#PROMPT='%{$FG[008]%}[%(!.%{$fg_bold[red]%}.%{$FG[039]%}%n@)%m %{$fg[cyan]%}%(!.%1~.%~) $(git_prompt_info)%_%{$FG[008]%}$(prompt_char)%{$reset_color%} '
PROMPT='%{$FG[008]%}[%(!.%{$fg_bold[red]%}.%{$fg[cyan]%}%(!.%1~.%~) $(git_prompt_info)%_%{$FG[008]%}$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
