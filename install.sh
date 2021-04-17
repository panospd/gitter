#!/bin/bash

./isroot.sh;

if [[ "${?}" -ne 0 ]]
then
  exit 1;
fi

echo "Deploying scripts.."

for f in $(find . -name "*.sh")
do
 file=$(basename -- "${f}");
 file="${file%.*}";
 path="/usr/local/bin/${file}";
 
 cp $f "/usr/local/bin/${file}";
 chmod 755 $path;
done

echo "Scripts deployed succesfully!";
