#!/bin/bash

 if grep -q dvorak_stian /usr/share/X11/xkb/symbols/no; then
	echo "Norwegian Dvorak Custom Stian, is already added"
	else
		
		if cat no_dvorak_stian >> /usr/share/X11/xkb/symbols/no; then
			echo "Added Custom Norwegian Dvorak for Stian.."
		fi
	fi 
