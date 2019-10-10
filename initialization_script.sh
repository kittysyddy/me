cp config $HOME/.ssh/
cp .bash_profile $HOME/
source $HOME/.bash_profile
cp .vimrc $HOME/
brew cask install sublime-text
brew install lastpass-cli
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
rm -rf get-pip.py
pip install tokendito --user

# need to automate this
ssh-keygen -t rsa -b 4096 -C "30902737+sydneysweeneydj@users.noreply.github.com" -P ""

eval "$(ssh-agent -s)"
ssh-add -K $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub | pbcopy