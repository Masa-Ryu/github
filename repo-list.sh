#!/bin/sh

GITHUB_TOKEN=''
LOGIN_NAME=''

repos=$(curl https://${LOGIN_NAME}:${GITHUB_TOKEN}@api.github.com/user/repos?per_page=1000 | \
jq -r '.[].full_name' | \
sort)
count=0
array=()
for repo in $repos
do
  count=`expr $count + 1`
  array=("${array[@]}" $repo)
  echo "$count)$repo"
done
echo "If you want to clone from github, please type the number."
read num
num=`expr $num - 1`
if [ $? -lt 2 ]
then
  git clone https://github.com/${array[$num]}
fi
echo "Bye."
