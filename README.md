# Ansible Workstation Setup
Configure OSX Workstation
## Setup
  - Check out project to local directory
```bash
git clone https://github.com/ajanis/ansible-computer-setup.git
```
  - Install user role via galaxy
```bash
cd ansible-computer-setup
ansible-galaxy role install -r roles/requirements.yml
```
  - Create inventory groups and hosts entries for your workstation in 'hosts' file
```yaml
all:
  children:
    alan:
      hosts:
        blitzwing:
              ansible_ssh_host: 10.0.12.100
              ansible_connection: local
              ansible_user: alan
              ansible_password: !vault |
                  $ANSIBLE_VAULT;1.1;AES256
                  32653836336338313835343233353734306138623934643936343830393331373636323934626231
                  3634633339623461306463666539306435373964343866390a336361343863306563663963373032
                  37316262353237663439373835633236363037376362323332386565643834383563396335623838
                  6331346661353161350a666534313938656333353336666162643464306663386436323462393239
                  3739
              ansible_become_password: !vault |
                  $ANSIBLE_VAULT;1.1;AES256
                  65323535636136656638363061393161333563393332333766333561356566313137393238613364
                  3566643665646639646434333961313234323166326133380a633664383261363233333136316431
                  66333763666139366530313639343637396635333865653531663739323835386237373462656166
                  6264383735373364380a306237333065363164343932636461643130313861383230396431336639
                  3737
```
  - Create necessary group_vars files for extended vars
```yaml
---
local_username: ajanis
local_user_shell: /bin/zsh

homebrew_user_packages:
  - ssh-copy-id
  - jq
  - ccze
  - freetype
  - tree
  - redis
  - telnet
  - tmux
  - screen
  - python
  - git
  - nmap
  - lftp
  - ipmitool
  - ansible
  - unrar
  - p7zip
  - minicom
  - coreutils
  - spice-gtk

homebrew_cask_user_packages:
  - dropbox
  - onedrive
  - tftpserver
  - istat-menus
  - gimp
  - 1password
  - bartender
  - synergy
  - osxfuse
  - google-chrome
  - slack
  - microsoft-teams
  - firefox
  - signal
  - spotify
  - sublime-text
  - xquartz
  - virtualbox
  - java
  - fluid
  - viscosity
  - moom
  - iterm2
  - font-hack-nerd-font-mono
  - font-hack-nerd-font
  - font-sourcecodepro-nerd-font-mono
  - font-sourcecodepro-nerd-font
  - font-source-code-pro
  - font-meslo-nerd-font-mono
  - font-meslo-nerd-font
  - font-anonymouspro-nerd-font-mono
  - font-anonymouspro-nerd-font
  - font-anonymous-pro

python3_pkgs:
  - ansible
  - passlib
  - redis
  - ansible-tower-cli

ssh_private_key: "{{ vault_alan_ssh_private_key }}"

ssh_public_key: "{{ vault_alan_ssh_public_key }}"

git_config: |
  [user]
    email = alan.janis@gmail.com
    name = Alan Janis
  [core]
    fileMode = true
  [alias]
    pushall = !git remote | xargs -L1 -I R git push R master
    modpull = "!git submodule foreach \"git checkout -f master; git pull\""
    modpush = "!git submodule foreach \"git checkout -f master; git pushall\""


bash_profile: |
  # Bash profile that syncs bash profile and other pref files

  export PROMPT_COMMAND="history -a"
  shopt -s histappend

  export GITAWAREPROMPT="${HOME}/.bash/git-aware-prompt"
  source "${GITAWAREPROMPT}/main.sh"

  # If you use macports
  if [ -d /opt/local/bin ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:/home/ldap/misc/openstack:/usr/local/Cellar:/usr/local/bin:$PATH
  fi

  if [ -e "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]; then
    export EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -w"
  fi

  # Shell color options
  export force_color_prompt=yes
  export CLICOLOR=1
  export LSCOLORS=ExFxcxdxcxegedbxgxEbEg

  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  # colored GCC warnings and errors
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

  # Bash Prompt
  case $TERM in
    xterm*|xterm|linux)
      export PS1="\[$txtred\]\h\[$txtcyn\] \u:\[$txtrst\]\w\[$txtwht\]\[$txtrst\]:\[$txtpur\]\$git_branch\[$txtrst\]\$git_status "
      ;;
    *)
      export PS1="\h:\w \u\$ "
      ;;
  esac

  if type brew 2&>/dev/null; then
    for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
      source "$completion_file"
    done
  fi

ssh_config: |
  ForwardAgent yes
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  ServerAliveInterval 240
  TCPKeepAlive yes
  LogLevel QUIET
  XAuthLocation /usr/X11/bin/xauth

zshrc: |
 ...
 ...

p10krc: |
  ...
  ...


```
  - Add sensitive data to 'vault.yml' file
## Run Playbook
  - Run 'user.yml' playbook against new host
```bash
ansible-playbook -l <newhost> --ask-vault-pass --ask-pass --ask-become-pass user.yml
```
