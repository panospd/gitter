#!/bin/bash

isgit;

if [[ "${?}" -ne 0 ]]
then
  exit 11;
fi;

usage() {
  echo "Invalid argument"
  echo "USAGE ${0} [-n] BRANCHTOCHECKOUT";
  echo "  -n   Force create new branch if not exist.";
  exit 1;
}

checkoutNewBranch() {
  git checkout -b $TARGETBRANCH &> /dev/null

  if [[ "${?}" -ne 0 ]] 
  then
    echo "Could not create new branch." 1>&2
    exit 1;
  fi

  echo "Successfully created branch $TARGETBRANCH";
  echo "Switched to branch $TARGETBRANCH";

  exit 0;
}

createNewBranchInputValidation() {
  if [[ ${CREATENEW} == "y" ]] || [[ ${CREATENEW} == "n" ]] 
  then
    VALIDINPUT='true';
  else
    VALIDINPUT='false';
  fi
}

while getopts "n" OPT;
do
  case ${OPT} in
    n) 
      FORCECREATENEWBRANCH=1
      ;;
    ?) usage ;;
  esac
done

shift $((OPTIND-1))

if [[ "${#}" -ne 1 ]]
then
  usage;
fi

TARGETBRANCH=$1;
CURRENTBRANCH=$(git branch --show-current);

if [[ "$CURRENTBRANCH" = "${TARGETBRANCH}" ]]
then
  echo "Already in branch ${CURRENTBRANCH}";
  exit 0;
fi

BRANCHEXISTS=$(git branch --list $TARGETBRANCH);

if [[ "${BRANCHEXISTS}" == *"$TARGETBRANCH"* ]]
then
  git checkout $TARGETBRANCH &> /dev/null;
  echo "Switched to branch $TARGETBRANCH";
  exit 0;
fi

if [[ $FORCECREATENEWBRANCH -eq 1 ]]
then
  checkoutNewBranch
  exit 0;
fi

echo "${TARGETBRANCH} branch does not exist. Do u want to create and checkout branch ${TARGETBRANCH}"
VALIDINPUT='false';

while [[ $VALIDINPUT == 'false' ]] 
do
  echo "Allowed input is y or n."
  read CREATENEW;

  createNewBranchInputValidation;
done

if [[ $CREATENEW == 'y' ]]
then
  checkoutNewBranch
  exit 0;
fi

echo "Aborted operation. Stayed in branch ${CURRENTBRANCH}";
exit 0;


