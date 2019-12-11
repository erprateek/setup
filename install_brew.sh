#!/bin/bash

#Homebrew is made with Ruby, so it will be modifying your computer’s Ruby path. The curl command pulls a script from the specified URL. This script will explain what it will do and then pauses the process to prompt you to confirm. This provides you with a lot of feedback on what the script is going to be doing to your system and gives you the opportunity to verify the process.

#If you need to enter your password note that your keystrokes will not display in the Terminal window but they will be recorded, simply press the return key once you’ve entered your password. Otherwise press the letter y for “yes” whenever you are prompted to confirm the installation.

#Let’s walk through the flags that are associated with the curl command:

#The -f or --fail flag tells the Terminal window to give no HTML document output on server errors.
#The -s or --silent flag mutes curl so that it does not show the progress meter, and combined with the -S or --show-error flag it will ensure that curl shows an error message if it fails.
#The -L or --location flag will tell curl to redo the request to a new place if the server reports that the requested page has moved to a different location.
#Once the installation process is complete, we’ll put the Homebrew directory at the top of the PATH environment variable. This will ensure that Homebrew installations will be called over the tools that Mac OS X may select automatically that could run counter to the development environment we’re creating.

xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew --version
brew doctor
echo "Before: $PATH"

echo $PATH | grep -q "/usr/local/bin"

if [ $? -eq 0 ]; then
  PATH=$PATH:/usr/local/bin
  export PATH
else
  export PATH
fi

echo ""
echo "After: $PATH"
brew install zsh zsh-completions 
