#!/bin/bash
VARFILE=/home/jameson/.scripts/WINDOWVISIBLE

WINDOWVISIBLE=`cat $VARFILE`

if [ $WINDOWVISIBLE -eq 1 ]; then
	echo "visible"
	wmctrl -r "Trello - Google Chrome" -b remove,above
	wmctrl -r "Trello - Google Chrome" -b add,hidden,below
	wmctrl -r "iPartnr Mail" -b remove,above
	wmctrl -r "iPartnr Mail" -b add,hidden,below
	wmctrl -r "Skype" -b remove,above
	wmctrl -r "Skype" -b add,hidden,below
	wmctrl -r "iPartnr8" -b remove,above
	wmctrl -r "iPartnr8" -b add,hidden,below
	wmctrl -r "GitLab" -b remove,above
	wmctrl -r "GitLab" -b add,hidden,below
	wmctrl -r "ShiftPlanning.com" -b remove,above
	wmctrl -r "ShiftPlanning.com" -b add,hidden,below
	wmctrl -r "iPartnr Slack" -b remove,above
	wmctrl -r "iPartnr Slack" -b add,hidden,below
	echo 0 > $VARFILE
else
	echo "not visible"
	wmctrl -r "Trello - Google Chrome" -b remove,hidden,below
	wmctrl -R "Trello - Google Chrome"
	wmctrl -r "Trello - Google Chrome" -b add,above
	wmctrl -r "Skype" -b remove,hidden,below
	wmctrl -R "Skype"
	wmctrl -r "Skype" -b add,above
	wmctrl -r "iPartnr8" -b remove,hidden,below
	wmctrl -R "iPartnr8"
	wmctrl -r "iPartnr8" -b add,above
	wmctrl -r "GitLab" -b remove,hidden,below
	wmctrl -R "GitLab"
	wmctrl -r "GitLab" -b add,above
	wmctrl -r "ShiftPlanning.com" -b remove,hidden,below
	wmctrl -R "ShiftPlanning.com"
	wmctrl -r "ShiftPlanning.com" -b add,above
	wmctrl -r "iPartnr Slack" -b remove,hidden,below
	wmctrl -R "iPartnr Slack"
	wmctrl -r "iPartnr Slack" -b add,above
	echo 1 > $VARFILE
fi
