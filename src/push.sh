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

if [[ "$#" -gt 2 ]]
then 
    echo "${0} expects only two optional arguments, REMOTE_NAME and REMOTE_BRANCH_NAME";
    usage;
fi

if [[ "$#" -gt 0 ]]
then 
    REMOTE=$1;
    shift;
fi

if [[ "$#" -gt 0 ]]
then 
    BRANCH=$1;
    shift;
fi

git push ${REMOTE} ${BRANCH} &> /dev/null

if [[ "${?}" -ne 0 ]]
then 
    echo "Could not push changes to ${REMOTE} ${BRANCH}";
    exit 1;
fi

echo "Pushed changes to ${REMOTE} ${BRANCH}."
exit 0;
