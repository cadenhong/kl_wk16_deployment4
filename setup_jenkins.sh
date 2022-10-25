#!/bin/bash

# If a Jenkins server does not exist already, run this script on the default VPC's EC2
# This script will install Jenkins and required Python packages to set up a Jenkins server

sudo apt install python3-pip python3-10-venv

sudo apt update && sudo apt install default-jre

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update && sudo apt install jenkins -y

sudo systemctl start jenkins