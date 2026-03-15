#!/bin/bash

#fileapath
usersFile="users.txt"

#Default pass
defPassword="changeme@123"



if [ ! -f $userFile ]; then
	echo "ERROR: users.txt does not exist"
	exit 1
fi

while IFS= read -r USER; do
	if id "$USER" &> /dev/null; then
		echo "User already exists so skipping"
	else

		#create user with home directoy
		useradd -m "$USER"

		#setdefault pass
		echo "$USER:$defPassword" | chpasswd

		#force user to change pass after they login
		chage -d 0 "$USER"

		echo "User: $USER created successfully"

	fi

done < "$usersFile"
