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

while getopts "r:" OPT;
do
  case ${OPT} in
    r) 
      REMOTE="${OPTARG}" 
      ;;
    ?) usage ;;
  esac
done

shift $((OPTIND-1))

if [[ "$#" -gt 1 ]]
then 
    echo "${0} expects only on optional argument, which is the branch name to push changes against.";
    exit 1;
fi

if [[ "$#" -eq 1 ]]
then 
    BRANCH=$1;
    shift;
fi

git push ${REMOTE} ${BRANCH}

if [[ "${?}" -ne 0 ]]
then 
    echo "Could not push changes to ${REMOTE} ${BRANCH}";
    exit 1;
fi

echo "Pushed changes to ${REMOTE} ${BRANCH}."
exit 0;
