#!/bin/bash

usage() {
  echo "Usage: ${0} [REMOTE_NAME] [REMOTE_BRANCH]";
  echo " REMOTE_NAME The remote to push changes to";
  echo " REMOTE_BRANCH The remote branch to push changes against";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'
BRANCH=$(git branch --show-current);

git pull $REMOTE $BRANCH