# !/bin/bash

sudo apk upgrade 
sudo apk update
sudo apk add openssh zsh python3 ctags the_silver_searcher zsh-vcs git-zsh-completion tmux-zsh-completion zsh-doc grep perl less ncurses tzdata coreutils iputils
sudo pip3 install --upgrade pip
sudo pip3 install requests
sudo pip install todotxt-machine
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime

# Setup SSH
mkdir -p ~/.ssh
sudo mv github* ~/.ssh
sudo chown flower:flower ~/.ssh/*
echo "github.com,192.30.253.113 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/*
chmod 700 ~/.ssh
cd ~
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github

# Setup ZSH
cd ~
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:leannenorthrop/.dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status

# Setup VIM
cd ~/.vim_runtime/
python3 ./update_plugins.py
cd ~
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Setup GIT

# Setup SBT
mkdir -p ~/.sbt/0.13/plugins
echo 'realm=Sonatype Nexus Repository Manager' >> ~/.sbt/.credentials
echo '#host=nexus-preview.tax.service.gov.uk' >> ~/.sbt/.credentials
echo 'host=nexus-dev.tax.service.gov.uk' >> ~/.sbt/.credentials
echo 'user=leanne.northrop' >> ~/.sbt/.credentials
echo 'password=Pass1wordstar!' >> ~/.sbt/.credentials
sbt --version
