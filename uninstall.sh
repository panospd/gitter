#!/bin/bash

./isroot.sh;

if [[ "${?}" -ne 0 ]]
then
  exit 1;
fi

echo "Uninstalling gitter...";

for f in $(find . -name "*.sh")
do
  filename=$(basename -- "${f}");
  filename="${filename%.*}";
  path="/usr/local/bin/${filename}";
  rm $path;
done  

echo "Gitter is successfully uninstalled"

exit 0;
