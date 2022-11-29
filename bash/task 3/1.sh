source ./functions.test

if [[ $(rootprivilages) == ' the user has root privilages ' ]]
	then
		echo " tmam "
		select choice in 'root privilages check' 'change ssh port' 'disable root login' 'add new user' 'backup home directory' 'group with specific gid' 'update system' 'reports-backup&sync' 'epel&fail2ban' 'exit'
				
			do
				case $choice in 
						'root privilages check') rootprivilages; break;;
						'change ssh port') changeport; break;;
						'disable root login') disableroot; break;;
						'add new user') adduser; break;;
						'backup home directory') backup; break;;
						'group with specific gid') group_id; break;;
						'update system') update_upgrade; break;;
						'reports-backup&sync') bak-sync-reports; break;;
						'epel&fail2ban') EPELREPO; break;;
						'exit') exit 0; break;;
						*) echo "please enter a valid choice";
				
				esac
			done
fi