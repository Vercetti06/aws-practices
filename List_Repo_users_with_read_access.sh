#!/bin/bash

#######################

#Author: Yaswanth

#Date: 11/1/2025

#Purpose: To list the users having the read only access to the repository

#######################

script_exec_guide()

#Git hub API Url
API_Curl=”https://github.com”

#Extracting the username and Token from the environment variables
Username=$username
Token=$token

#Assiging the command Line arguements to the variables
Repo_owner=$1
Repo_user=$2

#Function to make the get request to the GitHub API
function API_get_curl 
{
local endpoint="$1"
local api_call="$API_Curl/$endpoint"

#Send the request to GitHub API with authentication
curl -s -u "${Username}:${Token}" "$api_call"
}

#Function to list the users who are having the read access
function list_user_with_read_access
{
local endpoint="repos/${Repo_owner}/${Repo_user}/Collaborators"

#Curl the repo info and extracting only the user with read access info using jq parsing
Collaborators_read="$(API_get_curl "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

#Listing the users with read access
if [[ -z "$Collaborators_read" ]];
then
echo "There are no Collaborators with read permission for ${Repo_owner}/${Repo_user}."
else
echo "the list of users with collaborators permssion in ${Repo_owner}/${Repo_user}:"
echo "$Collaborators_read"
fi
}

#Function to guide the script execution
function script_exec_guide{
Expected_CL_Args=2
if [ $# -ne $Expected_CL_Args ];
then
echo "please execute the script with the required arguments"
echo "like './script_to_exec Repo_Owner Repo_name' " 
fi
}

#main script

echo "Listing the users with the read access to ${Repo_owner}/${Repo_user}.."
list_user_with_read_access

