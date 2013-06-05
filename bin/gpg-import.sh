#!/bin/bash 
gpg --keyserver keyserver.ubuntu.com --recv $1
gpg --export --armor $1 | sudo apt-key add --
