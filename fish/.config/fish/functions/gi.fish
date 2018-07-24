# create `.gitignore` for given project type
function gi
	curl -L -s https://www.gitignore.io/api/$argv
end
