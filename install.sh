#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo "Please run the script with root priviledges";
  exit 1;
fi

echo "Deploying scripts.."

for f in *
do
 chmod 755 $f;
 cp $f /usr/local/bin;
done

echo "Scripts deployed succesfully!";
