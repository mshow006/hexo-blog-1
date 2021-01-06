#!/bin/bash  
echo "#########deploy hexo#########"
hexo clean && hexo g && hexo d

echo "#########deploy git#########"
host=$(git status | sed -n 2p | awk -F\' '{print $2}' | awk -F/ '{print $1}')
branch=$(git status | sed -n 2p | awk -F\' '{print $2}' | awk -F/ '{print $2}')
git add .
read -p "commit massage:" $1
git commit -m $1
git push "$host" "$branch"
