source ./function.task.sh

if [[ $(rootprivilages) == ' the user has root privilages ' ]]
        then
                echo "Done"
                select choice in 'root privilages check' 'change ssh port' 'disable root login' 'add new user' 'backup home directory' 'exit'

                        do
                                case $choice in
                                                'root privilages check') rootprivilages; break;;
                                                'change ssh port') changeport; break;;
                                                'disable root login') disableroot; break;;
                                                'add new user') adduser; break;;
                                                'backup home directory') backup; break;;
                                                'exit') exit 0; break;;
                                                *) echo "please enter a valid choice";

                                esac
                        done
fi
~
~
