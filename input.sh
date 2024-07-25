#!/bin/bash

echo -n "Enter your name: "
read name

if [ $name == "George" ]
then
	echo "Welcome $name"
else
	echo "goodbye!"
