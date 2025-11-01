#!/bin/bash

#######################
# Author: Yaswanth
# Date: 11/1/2025
# Purpose: To list the users having read-only access to a GitHub repository
#######################

# GitHub API URL
API_Curl="https://api.github.com"

# Extracting the username and Token from environment variables
Username=$username
Token=$token

# Assigning the command line arguments to variables
Repo_owner=$1
Repo_user=$2

# Function to guide the script execution
function script_exec_guide {
    Expected_CL_Args=2
    if [ $# -ne $Expected_CL_Args ]; then
        echo "Please execute the script with the required arguments"
        echo "Like: './script_to_exec Repo_Owner Repo_name'"
        exit 1
    fi
}

# Function to make the GET request to the GitHub API
function API_get_curl {
    local endpoint="$1"
    local api_call="$API_Curl/$endpoint"

    # Send the request to GitHub API with authentication
    curl -s -u "${Username}:${Token}" "$api_call"
}

# Function to list users who have read access
function list_user_with_read_access {
    local endpoint="repos/${Repo_owner}/${Repo_user}/collaborators"  

    # Call the repo info and extract users with read access using jq
    Collaborators_read="$(API_get_curl "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # List the users with read access
    if [[ -z "$Collaborators_read" ]]; then
        echo "There are no collaborators with read permission for ${Repo_owner}/${Repo_user}."
    else
        echo "The list of users with read access to ${Repo_owner}/${Repo_user}:"
        echo "$Collaborators_read"
    fi
}

# Ensure script is run with correct number of arguments
script_exec_guide "$@"

# Main script execution
echo "Listing users with read access to ${Repo_owner}/${Repo_user}..."
list_user_with_read_access

