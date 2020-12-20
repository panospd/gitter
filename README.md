# gitter
A lightweight git wrapper for the command line to boost productivity. 

# Installation
Download the zipped package and unzip it. Navigate in the root directory where the install.sh file exists. Run "sudo ./install.sh"

# Usage
Git commit made easy. stage commit and optionally push changes in one command.
Example: commit -m "Your message" [-p]
-m option is the message option parameter and -p is optional parameter that, when specified pushes changes to remote origin

Deleting branch made easy.
The current branch can be deleted by simply running a command and optionally provide a branch to go to. The branch to go to defaults to master.
deleteme [-g BRANCHTOGOTO]
The above command will git checkout BRANCHTOGOTO and then will delete the previously checked out branch

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
