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

checkoutExistingBranchInputValidation() {
  if [[ ${CHECKOUTBRANCH} == "y" ]] || [[ ${CHECKOUTBRANCH} == "n" ]] 
  then
    VALIDINPUT='true';
  else
    VALIDINPUT='false';
  fi
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
CURRENTBRANCH=$(git branch --show-current);

BRANCHALREADYEXISTS=$(git branch --list $NEWBRANCH);

if [[ "$CURRENTBRANCH" = "${NEWBRANCH}" ]]
then
  echo "You are already in ${CURRENTBRANCH} branch";
  exit 0;
fi

if [[ "${CHECKOUTNEWBRANCH}" = 'false' ]] && [[ "${BRANCHALREADYEXISTS}" == *"$NEWBRANCH"* ]]
then
  echo "Branch ${NEWBRANCH} already exists. Nothing to be done."
  echo "Currently in branch ${CURRENTBRANCH}"
  exit 0;
fi

if [[ "${BRANCHALREADYEXISTS}" == *"$NEWBRANCH"* ]]
then
  echo "Branch already exists. Do u want to checkout $NEWBRANCH? (y/n)";

  VALIDINPUT='false';
  while [[ $VALIDINPUT == 'false' ]] 
  do
    echo "Allowed input is y or n."
    read CHECKOUTBRANCH;

    checkoutExistingBranchInputValidation;
  done

  if [[ "${CHECKOUTBRANCH}" = "y" ]]
  then
    git checkout $NEWBRANCH;
    echo "Switched to branch ${NEWBRANCH}";
    exit 0;
  else
    echo "Nothing to be done. Currently in branch ${CURRENTBRANCH}"
    exit 0;
  fi
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
echo "You are in branch $BRANCHNOW";

exit 0;
