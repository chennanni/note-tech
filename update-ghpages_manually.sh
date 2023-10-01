#!/bin/bash

# NOTE: need to create the folder first in windows
WORK_DIR=F:/CODEBASE/note-tech-ghpages-temp-bkp/ghpagesclone
WORK_FOLDER=ghpagesclone

# function to pause
get_char()
{
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

echo "cd ${WORK_DIR}"
cd ${WORK_DIR}

echo "1. update project"
echo "git pull"
git pull

echo "2. clean archive folder"
echo "rm -rf archive/*"
rm -rf archive/*

echo "3. update submodule"
echo "submodule update --init --recursive"
git submodule update --init --recursive
echo "submodule update --remote"
git submodule update --remote

# Setup Git
git config user.name "chennanni"
git config user.email "chennancd@gmail.com"

echo "4. push changes"
if git status | grep archive > /dev/null 2>&1
then
  # it should be committed
  git add .
  git commit -m ":sunny: Manually Update"
  git push origin gh-pages
  echo "**********DEPLOY SUCCESS**********"
else
  echo "no change, exit"
fi

# wait for confirm
echo "Press any key to continue ..."
echo " CTRL+C break command bash ..."
char=`get_char`