export LANG=ja_JP.UTF-8
if [ -s /usr/local/bin/zsh ]
then
  export SHELL=/usr/local/bin/zsh   #自分のzshのPath
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

