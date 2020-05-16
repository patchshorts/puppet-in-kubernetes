#!/bin/bash
sleep 60
while true;do
	/usr/bin/env puppet agent -t;
	sleep 450
done

