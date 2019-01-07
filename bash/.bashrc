function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

function git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/$/ /'
}

export PS1="\[\e[31m\]\`nonzero_return\`\]\e[37m\]\u\[\e[m\] \[\e[32m\]\W\[\e[m\] \$(git_branch)\\$ "
