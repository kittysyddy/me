cp config $HOME/.ssh/
cp .bash_profile $HOME/
source $HOME/.bash_profile
cp .vimrc $HOME/
brew cask install sublime-text
brew install lastpass-cli
brew install terraform@0.11
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py
pip install tokendito --user
pip install awscli --user
brew cask install amazon-music

# need to automate this
ssh-keygen -t rsa -b 4096 -C "30902737+sydneysweeneydj@users.noreply.github.com" -P ""

eval "$(ssh-agent -s)"
ssh-add -K $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub | pbcopy