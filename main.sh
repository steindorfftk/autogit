#!/bin/bash

function exit_exception () {
if [ $? -eq 130 ]; then
	echo "Exiting..."
	exit 1
fi	
}

function switch_branch (){

selected=$(git branch | fzf +m \
	--height 40% \
 	--layout reverse \
 	--border \
 	--preview 'git -c color.ui=always log --oneline $(echo {} | tr -d "* ")' \
 	--color bg:#222222,preview-bg:#333333
	)
	
exit_exception	
selected=$(echo $selected | tr -d "* ")
echo "Selected branch: $selected \n"
git switch "$selected"
}

function merge_branches (){

selected=$(git branch | fzf +m \
	--height 100% \
 	--layout reverse \
 	--border \
 	--preview 'git -c color.ui=always diff $(git branch | grep "^*" | tr -d "* " ) $(echo {} | tr -d "* ")' \
 	--color bg:#222222,preview-bg:#333333
	)
	
exit_exception	
selected=$(echo $selected | tr -d "* ")
echo "Selected branch: $selected \n"
git merge "$selected"
}

function delete_branch (){

selected=$(git branch | fzf +m \
	--height 40% \
 	--layout reverse \
 	--border \
 	--preview 'git -c color.ui=always diff $(git branch | grep "^*" | tr -d "* " ) $(echo {} | tr -d "* ")' \
 	--color bg:#222222,preview-bg:#333333
	)
	
exit_exception	
selected=$(echo $selected | tr -d "* ")
echo "Selected branch: $selected \n"
git branch -d "$selected"
}

function main (){
	options=("1 - Switch branch" "2 - Merge branches" "3 - Delete branch" "4 - Exit")
	selected=$( for opt in "${options[@]}" ; do echo $opt ; done | fzf +m \
	--height 40% \
 	--layout reverse \
 	--border \
 	--color bg:#222222,preview-bg:#333333
	
	
	
	exit_exception
	)
	
	case "$selected" in
		${options[0]})
			switch_branch 
			exit 0;;
		${options[1]})
			merge_branches 
			exit 0;;
		${options[2]})
			delete_branch 
			exit 0;;
		${options[3]})
			switch_branch
			exit 0;;
		*)
		exit 0
	esac	
		
	



}

main




































merge_branches
















switch_branch



