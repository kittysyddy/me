#!/bin/zsh
#
# Quick and dirty initial dev env setup script.
# Intended to be pulled down from the repo & ran on a Mac, 
# Monterey & later have zsh as the default shell
# py3 is already installed to my surprise
#
# What's achieved here: 
# - Move shell config files & set shell vars
# - Install homebrew
# - Install Sublime & config for it
# - python3 / pip3, virtualenv
# - cloud dev: aws cli, boto3, cloudformation cli
# - git & ssh keys

set -e

#########
# shell #
#########

cp ./art.txt $HOME/.art.txt # ascii art (｡•́‿•̀｡)
cp ./config/zprofile $HOME/.zprofile
cp ./config/zshrc $HOME/.zshrc
cp ./config/vimrc $HOME/.vimrc
source $HOME/.zprofile
source $HOME/.zshrc


########
# brew #
########

# Install brew
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add to path
eval "$(/opt/homebrew/bin/brew shellenv)"

# Just a peep
which brew
echo $PATH

###########
# Sublime #
###########
brew install --cask sublime-text
which subl
export DATA_DIR="$HOME/Library/Application Support/Sublime Text" # assuming MacOS
cp -r ./config/Sublime\ Text $DATA_DIR 


###########################
# Python (3) setup things #
###########################

# pip3 was already installed
# add py3 to path for the upcoming package installations to the local user
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
# get virtualenv

# Hygiene / update pip3, grab virtualenv & boto
pip3 install --no-input --upgrade pip
pip3 install --no-input virtualenv


#############
# cloud dev #
#############

pip3 install awscli
pip3 install boto3
brew install cloudformation-cli


#######
# git #
#######

brew install git

random_number=$((RANDOM % 100))
github_key_lcn="$HOME/.ssh/github_main$random_number"
github_email="30902737+kittysyddy@users.noreply.github.com"
ssh-keygen -t ed25519 -f $github_key_lcn -N "" -C $github_email
cat <<EOF >> $HOME/.gitconfig
[user]
    name = syd
    email = $github_email
EOF


# add new key to ssh config.
# file will be created if it does not exist
# the double > with cat makes it append
cat <<EOF >> $HOME/.ssh/config

Host github.com
  AddKeysToAgent yes
  IdentityFile $github_key_lcn

EOF

eval "$(ssh-agent -s)" # start ssh-agent in the background
ssh-add $github_key_lcn # add these new keys

github_key_pub=$github_key_lcn".pub"
echo "Adding public key to clipboard & opening GitHub"
open "https://github.com/settings/keys"
cat $github_key_pub | pbcopy
