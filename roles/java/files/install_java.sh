#!/bin/bash
#
# Working around a shortcoming of ansible where the command module cannot handle a pipe (|).
# And shame on Oracle for needing a \n to finish the install.
# Tren Blackburn - Symmetrics - April 29 2013
cd /indicee/java
echo -e \n | ./jdk-6u31-linux-x64.bin
rm -f jdk-6u31-linux-x64.bin
