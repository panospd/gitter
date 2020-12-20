#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo "Please run the script with root priviledges";
  exit 1;
fi

echo "Deploying scripts.."

for f in *.sh
do
 if [[ $f = "install.sh" ]]
 then
  continue;
 fi

 file=$(echo "$f" | cut -f 1 -d '.')
 path="/usr/local/bin/${file}";
 cp $f "/usr/local/bin/${file}";
 chmod 755 $path;
done

echo "Scripts deployed succesfully!";
