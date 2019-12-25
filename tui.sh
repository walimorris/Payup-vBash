#!/bin/bash

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

# Here, zero actually returns true/yes.
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
       
#Bill notification, when updated will always be written to 
# tui.txt. You can change this by changing the file. 
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

# to use notify-send here: assign bill to vaiable and call cat.
if [ "$?" = "0" ]; then 
    notification=$(cat tui.txt)
    notify-send "$notification" 
fi 
clear 

