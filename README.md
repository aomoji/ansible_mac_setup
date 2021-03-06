# ansible_mac_setup

Initial setup for macOS

# Requirements

* Command Line Tools `xcode-select --install`
* Ansible

# Roles

* [geerlingguy.homebrew](https://github.com/geerlingguy/ansible-role-homebrew): Installs homebrew, and installs specified packages and cask applications.
* zsh: Installs [prezto](https://github.com/sorin-ionescu/prezto) for zsh and a .zshrc file
* neovim: Installs [dein](https://github.com/Shougo/dein.vim) and a init.vim file. You may need to type `:call dein#install()` in vim, then the installation will be completed.
* fonts: Installs [Cica font](https://github.com/miiton/Cica).
* terminal: Installs alacritty.yml file.
* tmux: Installs .tmux.conf

# Quick start

1. Install ansible
    1. `sudo easy_install pip`
    1. `sudo pip install ansible`
1. Clone the repository
    1. `git clone https://github.com/aomoji/ansible_mac_setup.git`
1. Rewrite the `user_name`
    1. `cd ansible_mac_setup`
    1. open `exec.yml` and change `user_name` to your user name
1. Add packages and applications you want to `vars/main.yml`
    1. See `homebrew_installed_packages` variable for homebrew packages
    1. See `homebrew_cask_apps` variable for cask apps
    1. See `mas_installed_apps` variable for macOS apps
1. Run ansible
    1. `ansible-playbook -i hosts exec.yml --ask-become-pass`

