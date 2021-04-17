#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then 
  echo "Please run with with root priviledges";
  exit 11;
fi

exit 0;
