#!/bin/bash

read -p "Enter your name: " name

if [ $name == "George" ]
then
	echo "Welcome $name"
else
	echo "goodbye!"
