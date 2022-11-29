#user has root privilages

function rootprivilages()
{
	if [[ $(sudo whoami) == 'root' ]]
		then echo " the user has root privilages "
	else
		echo " you dont have the privilages "
	fi
}



#change port number

function changeport()
{	
	echo "please Enter a port number"
	read number
	echo "the new port number is $number" 
	sudo sed -i -e '/Port /c\Port '"$number"'' /etc/ssh/sshd_config
}



#Disable root login

function disableroot()
{
	sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
	echo "Disabled"
}



#adduser
function adduser()
{
	echo "please enter the username"
	read username
	sudo useradd $username
	sudo passwd $username
	echo " do you want to add the user to the sudeors y/n "
	read replay
	if [ $replay == 'y' ]
		then sudo usermod -aG wheel $username
		echo " $username has been added to the sudeors "
	else
		echo " Thank you "
	fi
}

#backup

function backup()
{	
	user=`whoami`
	touch ./back.script
	echo '1 * * * * tar cvf /home/backup/$user.tar /home/$user/' >> ./back.script
	crontab ./back.script
	rm ./back.script
}

backup
