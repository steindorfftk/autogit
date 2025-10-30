#!/bin/bash

function switch_branch (){

selected=$(git branch | fzf +m \
	--height 40% \
 	--layout reverse \
 	--border \
 	--preview 'git log --oneline $(echo {} | tr -d "* ")' \
 	--color bg:#222222,preview-bg:#333333
	)
	
echo "> $?"	
	
if [ $? -eq 130 ]; then
	echo "Exiting..."
	exit 1
fi	
	
selected=$(echo $selected | tr -d "* ")
echo "Selected branch: $selected \n"
git switch "$selected"
}

switch_branch



