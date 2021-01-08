#!/usr/bin/env bash
# Установка системного редактора по умолчанию. Редактор по умолчанию nano. 
# Если редактор до этого уже был прописан, то он будет заменен.
# (C) Alexandr Pavlov  <alexandr@asustem.ru>, 2021
# https://github.com/Zoviet/bashblog/
#

# Редактор по умолчанию

editor='nano';

[ -n "$1" ] && editor="$1";
grep -q 'export EDITOR=' $HOME/.bashrc && sed -i -e 's/\(export EDITOR=\)\(.*\)$/\1'$editor'/g' $HOME/.bashrc || echo 'export EDITOR='$editor >> $HOME/.bashrc
if [ -e $HOME/.bash_profile ]
then
grep -q 'export EDITOR=' $HOME/.bash_profile && sed -i -e 's/\(export EDITOR=\)\(.*\)$/\1'$editor'/g' $HOME/.bash_profile || echo 'export EDITOR='$editor >> $HOME/.bash_profile
else
echo 'export EDITOR='$editor > $HOME/.bash_profile
fi
exec "$BASH"
