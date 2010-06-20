#!/bin/sh
#Sync Experimental Branch with Master
	git checkout master
	echo "Checking Master is update"
	git pull origin master 
	git checkout experimental
	echo "Merging Experimental and Master"
	git merge master
	echo "Pushing Changes to Experimental"
	git push origin experimental
