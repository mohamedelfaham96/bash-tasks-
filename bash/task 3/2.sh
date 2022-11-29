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
	sudo semanage port -a -t ssh_port_t -p tcp $number
	sudo firewall-cmd --permanent --zone=public --add-port=$number/tcp
	sudo firewall-cmd --reload
}


#Disable root login

function disableroot()
{
	sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
	echo "Disabled"
}


#make a group with specific id

function group_id()
{
	echo " please enter the group name and the id "
	read groupname
	read idnumber
	groupadd -g $idnumber $groupname
}


#adduser
function adduser()
{
	echo "please enter the username,the group name & user id number"
	read username
	read grpname
	read usrid
	sudo useradd -u -g $usrid $grpname $username
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

#update system
function update_upgrade
{
	sudo yum update
}



#backup-sync-reports
function bak-sync-reports()
{
	PrYear="/home/USER/reports"
	rYear="2021"
	mkdir -p $PrYear
        chmod 1660 $PrYear
        touch $PrYear/$rYear-{01,03,05,07,08,10,12}-{01..31}.xls
        touch $PrYear/$rYear-{04,06,09,11}-{01..30}.xls
        touch $PrYear/$rYear-02-{01..28}.xls
        mkdir -p /home/manager/audit/reports/
        mkdir -p /root/backups/
        echo "00 02 * * 1-5 rsync -a $PrYear/ /home/manager/audit/reports/"  >> /etc/crontab
        echo "00 01 * * 1-5 tar cvf /root/backups/reports-\`date +%U-%u\`.tar $PrYear/"  >> /etc/crontab
        
}

#enable EPEL repository & fail2ban

function EPELREPO()
{
    dnf search epel
    echo "Installing EPEL repo"
    dnf install epel-release -y
    echo "Enable EPEL repo"
    dnf config-manager --set-enabled PowerTools || dnf install 'dnf-command(config-manager)' -y
    dnf config-manager --set-enabled PowerTools
    dnf update
    echo "Checking EPEL repo => Count packages in EPEL repo"
    dnf --disablerepo="*" --enablerepo="epel" list available | wc -l
    echo "Installing Some Missing Important Packages"
    dnf update -y && dnf install epel-release -y

    echo "Installing fail2ban Packages"
    dnf install fail2ban sendmail -y

    echo "Enable and start fail2ban service"
    systemctl enable --now fail2ban
    systemctl enable --now sendmail
}