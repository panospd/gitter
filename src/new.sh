#!/bin/bash

isgit;

if [[ "${?}" -ne 0 ]]
then
  exit 11;
fi;

usage() {
  echo "Invalid argument"
  echo "USAGE ${0} [-s] NEWBRANCH";
  echo "  -s    Optional parameter to stay in current branch";
  exit 1;
}

CHECKOUTNEWBRANCH="true";

while getopts "s" OPT
do
  case $OPT in 
    s) 
       CHECKOUTNEWBRANCH='false';
       shift;
       ;;
    *) usage ;;
  esac
done

if [[ "${#}" -ne 1 ]]
then
  usage;
fi

NEWBRANCH=$1;
echo $NEWBRANCH;
BRANCHALREADYEXISTS=$(git branch --list $NEWBRANCH);

if [[ "${BRANCHALREADYEXISTS}" == *"$NEWBRANCH"* ]]
then
  echo "Branch already exists. Do u want to checkout $NEWBRANCH? (y/n)"
  read CHECKOUTBRANCH;
  if [[ "${CHECKOUTBRANCH}" = "y" ]]
  then
    CURRENTBRANCH=$(git branch --show-current);
    echo $NEWBRANCH;  
    if [[ "$CURRENTBRANCH" = "${NEWBRANCH}" ]]
    then
      echo "You are already in ${CURRENTBRANCH}";
      exit 0;
    fi
    git checkout $NEWBRANCH;
  fi

  exit 0;
fi

if [[ "${CHECKOUTNEWBRANCH}" = 'true' ]]
then
  git checkout -b $NEWBRANCH &> /dev/null
else
  git branch $NEWBRANCH &> /dev/null
fi

if [[ "${?}" -ne 0 ]] 
then
  echo "Could not create new branch." 1>&2
  exit 1;
fi

echo "Successfully created branch $NEWBRANCH";

BRANCHNOW=$(git branch --show-current);
echo "You are in $BRANCHNOW";

exit 0;
