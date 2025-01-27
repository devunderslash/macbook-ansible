# This will run the initial setup for ansible to be able to run the playbook

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor

# Install pyenv
brew install pyenv

# Install python 3.10.4
pyenv install 3.10.4

echo 'export PATH="/usr/local/opt/python/libexec/bin:$PATH"' >> ~/.zshrc
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Install pip3
sudo pip3 install --upgrade pip

# Install ansible via pip3
sudo -H pip3 install ansible

# Install Ansible Roles
ansible-galaxy install -r requirements.yml
