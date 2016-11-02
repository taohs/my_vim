# /bin/bash

git clone 
echo "alias phptags='ctags --langmap=php:.engine.inc.module.theme.php  --php-kinds=cdf --languages=php'" >> ~/.bash_alias

if [ -f ~/.bash_alias ]; then
    . ~/.bash_profile
fi
