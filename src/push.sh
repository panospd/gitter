#!/bin/bash

usage() {
  echo "Usage: ${0} [-o ORIGIN] [-b BRANCH]";
  echo "  -o ORIGIN The remote origin of git";
  echo "  -b BRANCH The branch to push changes against";
  exit 1;
}

isgit;

if [[ "${?}" -ne 0 ]]
then 
  exit 2;
fi

REMOTE='origin'
BRANCH=$(git branch --show-current);

while getopts "o:b:" OPT;
do
  case ${OPT} in
    o) REMOTE="${OPTARG}" ;;
    B) BRANCH="${OPTARG}" ;;
    ?) usage ;;
  esac
done

git push ${REMOTE} ${BRANCH}

if [[ "${?}" -ne 0 ]]
then 
    echo "Could not push changes to ${REMOTE} ${BRANCH}";
    exit 1;
fi


echo "Pushed changes to ${REMOTE} ${BRANCH}."
