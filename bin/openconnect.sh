#!/bin/bash

conn_command="sudo /usr/bin/openconnect"
conn_args="-u ${vpn_user} --authgroup ${vpn_auth_group} ${vpn_host}"

cookie=$(${conn_command} ${conn_args} --cookieonly)

while [ $? = 0 ]
do
	${conn_command} ${conn_args} --cookie=${cookie}
done

