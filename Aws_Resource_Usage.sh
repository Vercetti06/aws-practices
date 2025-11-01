#!/bin/bash

##############################################
#Author : Yaswanth
#Project : KodeKloud
#Date Nov-1-2025
#
#Version-1
#
#Describes the usage of aws resources in the account
#
set -x # runs the commands in debug mode
set -o #

#aws s3
#aws ec2
#aws iam
#aws lambda

#print the list of buckets available in the account
echo "list of s3 buckets"
aws s3 ls

#describes the ec2 instances running in the account
echo "describe the ec2 instance"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#lists the iam users
echo "list the iam users"
aws iam list-users

