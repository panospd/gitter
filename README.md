# gitter

A lightweight git wrapper for the command line to boost productivity.

# Installation

## Download the zipped package and unzip it. Navigate in the root directory where the install.sh file exists. Run "sudo ./install.sh"

### This will copy all gitter script files and paste them under the /usr/local/bin/ folder. This folder is aleady part of the path hence you can start using gitter right away.

# How to use

## Commit changes

### Commit and optionally push changes to remote. You can use the commit command or the more compact aliases cmt or ct

#### commit -m "Your message" [-p Optional flag to push changes in remote branch] [REMOTE_NAME]

#### cmt -m "Your message" [-p] [REMOTE_NAME]

#### ct -m "Your message" [-p] [REMOTE_NAME]

## Push changes

### If changes are already committed locally then u can push your changes to remote by simply executing the push command.

#### Use case:

##### ct -m 'your message';

##### push [-r REMOTE_NAME] [BRANCHNAME];

## Status

### You can check the status by simply executing the status command. You can do it by simply typing status or st and execute.

## Fetch from remote

### You can fetch from remote by simply executing the fetch command. You can do it by simply typing fetch or fch and execute

## Undo changes

### You can undo tracked or untracked changes by simply executing the undo command with no arguments.

## Delete branch

### Deletes the current branch and optionally checks a specified branch. By default the target branch to checkout is master

#### deleteme [-g BRANCHTOGOTO]

## New branch

### Checkout existing or create new branch and check it out. Can optionally provide the -s flag to create the branch but stay in the currently checked out.

#### new [-s] BRANCHTOCHECKOUT

## Clear terminal

### A couple of aliases to clear the terminal

#### Type c or cls and is equivalent to clear.

# Uninstall gitter

## Simply go to the root of the gitter folder and run sudo ./uninstall.sh

### The command will uninstall all gitter scripts from your /usr/local/bin/ folder

# License

MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
