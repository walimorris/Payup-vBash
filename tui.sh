#!/bin/bash

# Payup was first written in C and Python, finishing up with a Bash script.  
# After reviewing the implementation, it seemed the process could be solely 
# written with a  Bash script. This solution provides a simple solution to do 
# what was written initially in C and Python. It requires less dependencies, 
# less code and seems to be a better solution. Currently, some improvements 
# would be to implement cron to run this script whenever needed/wanted. Some
# work around would be figuring out how cron could run such a process. 
# This is Payup v-Bash, utilizng the dialog library for simple terminal user
# interfaces and notify-send to send the desktop notifications. Please review
# the READ-ME file downloaded with this package for more information

################################################################################
# filename     : tui.sh
# Description  : A daily bill notifier 
# Author       : Wali Morris 
# Created      : 25-12-2019
################################################################################

clear 
cd -- 
#Create dialog box asking if user needs to install dialog 
dialog --title "Payup" \
       --yesno "\nInstall dialog?\n\nNote: System will also update!" 10 50 
if [ "$?" = 0 ]; then
    clear
    sudo apt-get update
    sudo apt-get install dialog 
fi

#Create updated notification
dialog --title "System update" \
       --msgbox "System has been updated and dialog installed!" 10 50 
    
#Create dialog box asking if user would like to update current bill 
dialog --backtitle "Notification configuration" \
       --title "Payup" \
       --yesno "\nUpdate Bill\n\nContinue or no to keep current bill?" 10 50

#Here, 0 actually returns true/yes. If yes, update bill. 
if [ "$?" = "0" ]; then 
    dialog --inputbox "Company: " 8 40 2>tui.txt
    dialog --inputbox "Due date: " 8 40 2>>tui.txt
    dialog --inputbox "ACC#: " 8 40 2>>tui.txt
    dialog --inputbox "TOT BAL: " 8 40 2>>tui.txt
    dialog --inputbox "PAYMT due: " 8 40 2>>tui.txt
fi       
# Bill is updated in a file called tui.txt, inform the user
dialog --backtitle "Notification configuration" \
       --title "Payup" --msgbox "Your bill has been configured. Would you like \
       to view?" 10 50

if [ "$?" = "0" ]; then 
    notification=$(cat tui.txt)
    notify-send "$notification" 
fi 
clear 

