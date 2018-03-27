#!/bin/sh

soapy_power --detect | grep driver= | while read driverline
do
    systemctl start litelog-sh-soapy_power-record@"$driverline"
done
