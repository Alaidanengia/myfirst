#!/bin/bash
#Author		: Ala
echo "Enter your GitHub Personal Access Token: "
read token
cat ~/.ssh/id_rsa.pub
#if condition to validate weather ssh keys are already present or not
if [ $? -eq 0 ]
then
	echo "SSH Keys are already present..."
else
	echo "SSH Keys are not present..., Create the SShkeys using ssh-keygen command"
ssh-keygen
echo "Key successfully generated"
fi
sshkeypub=`cat ~/.ssh/id_rsa.pub`
if [ $? -eq 0 ]
then
echo "Copying the key to GitHub account"
curl -X POST -H "Content-type: application/json" -d "{\"title\": \"SSHKEY\"}" "https://api.github.com/user/keys?access_token=$token"
if [ $? -eq 0 ]
then
echo "Successfully copied the token to GitHub"
exit 0
else
echo "Failed"
exit 1
fi
else
echo "Failure in generating the key"
exit 1
fi
