# !/bin/bash

sudo apk upgrade 
sudo apk update
sudo apk add openssh zsh python3 ctags the_silver_searcher zsh-vcs git-zsh-completion tmux-zsh-completion zsh-doc grep perl less ncurses tzdata coreutils iputils
sudo pip3 install --upgrade pip
sudo pip3 install requests
sudo pip install todotxt-machine
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime

mkdir -p ~/bin

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
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone git@github.com:paulirish/git-open.git ~/.oh-my-zsh/custom/plugins/git-open
curl -L https://iterm2.com/misc/zsh_startup.in -o ~/.iterm2_shell_integration.zsh
sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o ~/bin/spark && chmod +x ~/bin/spark"
sh -c "curl https://raw.githubusercontent.com/leannenorthrop/p/master/p -o ~/bin/pt && chmod +x ~/bin/pt"
sh -c "mkdir -p ~/.oh-my-zsh/custom/stime && curl https://raw.githubusercontent.com/gabrielelana/dotfiles/master/zsh/plugins/time/time.plugin.zsh -o ~/.oh-my-zsh/custom/plugins/stime/stime.plugin.zsh"
sed -i 's~ZSH_THEME="robbyrussell"~ZSH_THEME="powerlevel9k/powerlevel9k"~' /home/flower/.zshrc
sed -i 's~# COMPLETION_WAITING_DOTS="true"~COMPLETION_WAITING_DOTS="true"~' /home/flower/.zshrc
sed -i 's~plugins=(git)~plugins=(git osx common-aliases encode64 gulp history jira jsontools vi-mode emoji scala sbt zsh-syntax-highlighting history-substring-search zsh-syntax-highlighting git-open)~' /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Exports' >> /home/flower/.zshrc
echo 'export SBT_OPTS="-XX:+CMSClassUnloadingEnabled"' >> /home/flower/.zshrc
echo 'export PATH=~/bin:$PATH' >> /home/flower/.zshrc
echo 'export EDITOR="vim"' >> /home/flower/.zshrc
echo 'export VISUAL="vim"' >> /home/flower/.zshrc
echo 'export TERM="xterm-256color"' >> /home/flower/.zshrc
echo 'export LANG=en_UK.UTF-8' >> /home/flower/.zshrc
echo 'export LC_CTYPE=en_UK.UTF-8' >> /home/flower/.zshrc
echo 'export LC_ALL=en_UK.UTF-8' >> /home/flower/.zshrc
echo 'export CLICOLOR=1' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Source' >> /home/flower/.zshrc
echo 'source /home/flower/.oh-my-zsh/oh-my-zsh.sh' >> /home/flower/.zshrc
echo 'source /home/flower/.oh-my-zsh/plugins/history-substring-search/history-substring-search.zsh' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Aliases' >> /home/flower/.zshrc
echo 'function saw { ssh-add -D && ssh-add ~/.ssh/github }' >> /home/flower/.zshrc
echo 'function sad { ssh-add -D }' >> /home/flower/.zshrc
echo $'function gb() { printf "$(git branch | grep \* | cut -d \' \' -f2- 2> /dev/null)" }' >> /home/flower/.zshrc
echo 'function gp() { echo "On $(gb), pulling from origin $(gb)" && git pull origin $(gb) }' >> /home/flower/.zshrc
echo 'function gpu() { echo "On $(gb), pushing to origin $(gb)" && git push origin $(gb) }' >> /home/flower/.zshrc
echo 'function gc() { echo "On $(gb), commiting $(gb)" && git commit -e -m $(gb) }' >> /home/flower/.zshrc
echo 'alias gup="git fetch upstream && git checkout master && git merge upstream/master"' >> /home/flower/.zshrc
echo 'alias gentags="ctags -R -f ./.git/tags . && sbt gen-ctags"' >> /home/flower/.zshrc
echo 'alias vi="vim"' >> /home/flower/.zshrc
echo 'alias todo="todotxt-machine"' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Key binding' >> /home/flower/.zshrc
echo 'zmodload zsh/terminfo' >> /home/flower/.zshrc
echo 'bindkey -M vicmd 'k' history-substring-search-up' >> /home/flower/.zshrc
echo 'bindkey -M vicmd 'j' history-substring-search-down' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Prompt: powerlevel9k' >> /home/flower/.zshrc
#echo 'autoload -U promptinit; promptinit' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_MODE="nerdfont-complete"' >> /home/flower/.zshrc
echo 'DISABLE_AUTO_TITLE="true"' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo 'zsh_internet_signal(){' >> /home/flower/.zshrc
echo '  #Try to ping google DNS to see if you have internet' >> /home/flower/.zshrc
echo '  local net=$(ping -c 1 8.8.8.8 | grep transmitted | awk "{print $6}" | grep 0)' >> /home/flower/.zshrc
echo '  local color="%F{red}"' >> /home/flower/.zshrc
echo '  local symbol="\uf127"' >> /home/flower/.zshrc
echo '  if [[ ! -z "$net" ]] ;' >> /home/flower/.zshrc
echo '  then color="%F{green}" ; symbol="\uf1e6" ;' >> /home/flower/.zshrc
echo '  fi' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '  echo -n "%{$color%}$symbol" # \f1eb is wifi bars' >> /home/flower/.zshrc
echo '}' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo 'zsh_custom_ip(){' >> /home/flower/.zshrc
echo ' local ip=$(sudo ifconfig "eth0" | grep Bcast | awk "{print $2}" | cut -f2 -d ":")' >> /home/flower/.zshrc
echo ' local color="%F{green}"' >> /home/flower/.zshrc
echo ' echo -n "%{$color%}$ip"' >> /home/flower/.zshrc
echo '}' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo 'pomodoro() {' >> /home/flower/.zshrc
echo '  local pstatus="$(~/bin/pt ss)"' >> /home/flower/.zshrc
echo '  if [[ "$pstatus" =~ "^[]" ]]; then' >> /home/flower/.zshrc
echo '   local color="%F{blue}"' >> /home/flower/.zshrc
echo '   echo -e "$color$pstatus"' >> /home/flower/.zshrc
echo '  fi' >> /home/flower/.zshrc
echo '  if [[ "$pstatus" =~ "^" ]]; then' >> /home/flower/.zshrc
echo '   local color="%F{green}"' >> /home/flower/.zshrc
echo '   echo -e "$color$pstatus"' >> /home/flower/.zshrc
echo '  fi' >> /home/flower/.zshrc
echo '  if [[ "$pstatus" =~ "^" ]]; then' >> /home/flower/.zshrc
echo '   local color="%F{red}"' >> /home/flower/.zshrc
echo '   echo -e "$color$pstatus"' >> /home/flower/.zshrc
echo '  fi' >> /home/flower/.zshrc
echo '  if [[ "$pstatus" =~ "^" ]]; then' >> /home/flower/.zshrc
echo '   local color="%F{yellow}"' >> /home/flower/.zshrc
echo '   echo -e "$color$pstatus "' >> /home/flower/.zshrc
echo '  fi' >> /home/flower/.zshrc
echo '}' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Custom' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_POMODORO="pomodoro"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_POMODORO_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_INTERNET_SIGNAL="zsh_internet_signal"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_INTERNET_SIGNAL_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_IP="zsh_custom_ip"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_CUSTOM_IP_BACKGROUND="black"' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# Time' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_TIME_FOREGROUND='magenta'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_TIME_BACKGROUND='black'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M}"' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# DIR' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_HOME_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="blue"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_SHORTEN_DIR_LENGTH=4' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo '# VCS Status' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_CLEAN_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="black"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="red"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_UNTRACKED_ICON='?'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'' >> /home/flower/.zshrc
echo '' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_STATUS_VERBOSE=false' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_PROMPT_ON_NEWLINE=true' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_pomodoro time context dir dir_writable vcs)' >> /home/flower/.zshrc
echo 'POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status custom_internet_signal custom_ip            disk_usage os_icon)' >> /home/flower/.zshrc
echo 'export DEFAULT_USER="$USER"' >> /home/flower/.zshrc
echo 'ZSH_THEME="powerlevel9k/powerlevel9k"' >> /home/flower/.zshrc

echo 'rm -f .zcompdump*' >> /home/flower/.zshrc
echo 'sudo apk upgrade' >> /home/flower/.zshrc

# Setup VIM
git clone git@github.com:lavender-flowerdew/vimrc.git ~/.vim_runtime
cd ~/.vim_runtime/
python3 ./update_plugins.py
cd ~
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Setup GIT
git config --global user.name "Leanne Northrop"
git config --global user.email "leanne.northrop@gmail.com"
git config --global core.editor vim
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true

git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta "227"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.commit "227 bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"
git config --global color.diff.whitespace "red reverse"
curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o ~/bin/diff-so-fancy
chmod +x ~/bin/diff-so-fancy

# Setup SBT
mkdir -p ~/.sbt/0.13/plugins
echo 'realm=Sonatype Nexus Repository Manager' >> ~/.sbt/.credentials
echo '#host=nexus-preview.tax.service.gov.uk' >> ~/.sbt/.credentials
echo 'host=nexus-dev.tax.service.gov.uk' >> ~/.sbt/.credentials
echo 'user=leanne.northrop' >> ~/.sbt/.credentials
echo 'password=Pass1wordstar!' >> ~/.sbt/.credentials
echo 'import net.ceedubs.sbtctags.CtagsKeys' >> ~/.sbt/0.13/sbt-ctags.sbt
echo 'CtagsKeys.ctagsParams ~= (default => default.copy(tagFileName = "./tags-dep"))' >> ~/.sbt/0.13/sbt-ctags.sbt
echo 'resolvers ++= Seq(' >> ~/.sbt/0.13/plugins/plugins.sbt
echo '  "Sonatype OSS Releases" at "https://oss.sonatype.org/content/repositories/releases/",' >> ~/.sbt/0.13/plugins/plugins.sbt
echo '  "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots/"' >> ~/.sbt/0.13/plugins/plugins.sbt
echo ')' >> ~/.sbt/0.13/plugins/plugins.sbt
echo '' >> ~/.sbt/0.13/plugins/plugins.sbt
echo 'addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.2.0")' >> ~/.sbt/0.13/plugins/plugins.sbt
sbt --version

# Setup Todo
echo '[settings]' >> ~/.todotxt-machinerc
echo 'file = ~/.todo.txt' >> ~/.todotxt-machinerc
echo 'archive = ~/.done.txt' >> ~/.todotxt-machinerc
echo 'auto-save = True' >> ~/.todotxt-machinerc
echo 'show-toolbar = True' >> ~/.todotxt-machinerc
echo 'show-filter-panel = True' >> ~/.todotxt-machinerc
echo 'enable-borders = True' >> ~/.todotxt-machinerc
echo 'enable-word-wrap = True' >> ~/.todotxt-machinerc
echo 'colorscheme = myawesometheme' >> ~/.todotxt-machinerc
echo '' >> ~/.todotxt-machinerc
echo '[colorscheme-myawesometheme]' >> ~/.todotxt-machinerc
echo 'plain=h250,#000' >> ~/.todotxt-machinerc
echo 'selected=,g19' >> ~/.todotxt-machinerc
echo 'header=h250,h235' >> ~/.todotxt-machinerc
echo 'header_todo_count=h39,h235' >> ~/.todotxt-machinerc
echo 'header_todo_pending_count=h228,h235' >> ~/.todotxt-machinerc
echo 'header_todo_done_count=h156,h235' >> ~/.todotxt-machinerc
echo 'header_file=h48,h235' >> ~/.todotxt-machinerc
echo 'dialog_background=,h248' >> ~/.todotxt-machinerc
echo 'dialog_color=,h240' >> ~/.todotxt-machinerc
echo 'dialog_shadow=,h238' >> ~/.todotxt-machinerc
echo 'footer=h39,h235' >> ~/.todotxt-machinerc
echo 'search_match=h222,h235' >> ~/.todotxt-machinerc
echo 'completed=h59' >> ~/.todotxt-machinerc
echo 'context=h39' >> ~/.todotxt-machinerc
echo 'project=h214' >> ~/.todotxt-machinerc
echo 'creation_date=h135' >> ~/.todotxt-machinerc
echo 'due_date=h161' >> ~/.todotxt-machinerc
echo 'priority_a=#f00' >> ~/.todotxt-machinerc
echo 'priority_b=#f60' >> ~/.todotxt-machinerc
echo 'priority_c=#f80' >> ~/.todotxt-machinerc
echo 'priority_d=#fa0' >> ~/.todotxt-machinerc
echo 'priority_e=#ad0' >> ~/.todotxt-machinerc
echo 'priority_f=#09f' >> ~/.todotxt-machinerc
