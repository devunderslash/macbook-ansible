<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# Mac Development Ansible Playbook

This playbook installs and configures most of the software used on Mac for software development. Some things in macOS are slightly difficult to automate, so there are still a few manual steps, but much less than if you were to install all the software yourself. Please review the main files in this repository and change them approiately to your needs:
  - main.yml - This is the main playbook file.
  - default.config.yml - Contains all software and VS Code extensions
  - dotfiles - You should review the repo that this links to as the dotfiles used may not be to your liking.
  - VS Code - You should review that the VSCode extensions in main.yml are what you would want and also update the user to your username (currently set as admin).

## Installation

  1. Ensure Apple's command line tools are installed (xcode-select --install to launch the installer).
  2. Install both VSCode and iTerm from Company Portal
  3. Run the run-setup.sh script to install the required software.
  4. Run `ansible-playbook main.yml --ask-become-pass` inside this directory. Enter your macOS account password when prompted for the 'BECOME' password.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `homebrew`, `mas`, `extra-packages` and `osx`.

    ansible-playbook main.yml -K --tags "dotfiles,homebrew"

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by just updating them in situ or by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
homebrew_installed_packages:
  - cowsay
  - git
  - go

mas_installed_apps:
  - { id: 443987910, name: "1Password" }
  - { id: 498486288, name: "Quick Resizer" }
  - { id: 557168941, name: "Tweetbot" }
  - { id: 497799835, name: "Xcode" }

composer_packages:
  - name: hirak/prestissimo
  - name: drush/drush
    version: '^8.1'

gem_packages:
  - name: bundler
    state: latest

npm_packages:
  - name: webpack

pip_packages:
  - name: mkdocs

configure_dock: true
dockitems_remove:
  - Launchpad
  - TV
dockitems_persist:
  - name: "Sublime Text"
    path: "/Applications/Sublime Text.app/"
    pos: 5
```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

## Included Applications / Configuration (Default)

Applications (installed with Homebrew Cask):

  - [ChromeDriver](https://sites.google.com/chromium.org/driver/)
  - [Docker](https://www.docker.com/)
  - [Google Chrome](https://www.google.com/chrome/)
  - [Homebrew](http://brew.sh/)
  - [iTerm2](https://www.iterm2.com/)
  - [MySql](https://www.mysql.com/)
  - [Postgresql](https://www.postgresql.org/)
  - [Postman](https://www.getpostman.com/)
  - [Slack](https://slack.com/)
  - [Sourcetree](https://www.sourcetreeapp.com/)
  - [Vagrant](https://www.vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/)
  - [Visual Studio Code](https://code.visualstudio.com/)
  - [OpenJDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)

Packages (installed with Homebrew):
## Common Dev Tools
  - bash-completion
  - git
  - github/gh/gh
  - hub
  - go
  - gpg
  - mysql
  - sqlite
  - nmap
  - node
  - nvm
  - ssh-copy-id
  - readline
  - openssl
  - wget
  - zsh-history-substring-search
  - tmux
  - romkatv/powerlevel10k/powerlevel10k

  ## DevOps
  - awscli
  - jq
  - tree
  - warrensbox/tap/tfswitch
  - packer

  ## Java
  - jenv # Manage your Java environment
  - jmeter # Load testing and performance measurement application
  - maven # Java-based project management

My [dotfiles](https://github.com/devunderslash/dotfiles) are also installed into the current user's home directory, including the `.osx` dotfile for configuring many aspects of macOS for better performance and ease of use. You can disable dotfiles management by setting `configure_dotfiles: no` in your configuration.

Finally, there are a few other preferences and settings added on for various apps and services.
### Things that still need to be done manually

It's my hope that I can get the rest of these things wrapped up into Ansible playbooks soon, but for now, these steps need to be completed manually (assuming you already have Xcode and Ansible installed, and have run this playbook).

  1. Native MacOS terminal may need a font and theme update via preferences to take in changes made in .zshrc (MesloLGS NF Regular 13 and theme of your choice)
  2. Visual Studio Code may also need a font update via preferences:
    - Preferences > Editor > Font Size:  `"terminal.integrated.lineHeight": 1.3`
    - Preferences > Editor > Font Family: `"terminal.integrated.fontFamily": "MesloLGS NF"`
  3. For iTerm2, you may need to install a font via running `p10k configure` and then restart iTerm2.

## Testing the Playbook

This has been tested via Vagrant and VirtualBox using macOS Big Sur. Check the following repo with how to do this: https://github.com/devunderslash/Vagrant-Macos-BigSur

Or use this repo to build a [Mac OS X VirtualBox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm), on which you can continually run and re-run this playbook to test changes and make sure things work correctly.

## Ansible for DevOps

Check out [Ansible for DevOps](https://www.ansiblefordevops.com/), which teaches you how to automate almost anything with Ansible.

## Author

This project was created by [Jeff Geerling](https://www.jeffgeerling.com/) (originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)) and butchered by [Paul Devlin](https://github.com/devunderslash)

## Resources Used
These resources were used as the basis for the approach outlined above:

Install Python the right way - https://opensource.com/article/19/5/python-3-default-mac
The original mac-devops-setup - https://github.com/geerlingguy/mac-dev-playbook
Powerlevel10k - https://github.com/romkatv/powerlevel10k
Geerlingguy dotfiles - https://github.com/geerlingguy/dotfiles
Devunderslash dotfiles - https://github.com/devunderslash/dotfiles
Playbook with VSCode - https://github.com/DemisR/mac-devops-setup
Step by step ansible resource - http://www.talkingquickly.co.uk/2021/01/macos-setup-with-ansible/
Pyenv - https://github.com/pyenv/pyenv


TODO - add themes for iterm into ansible script
