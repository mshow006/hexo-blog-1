#!/bin/bash  
# deploy hexo
hexo clean && hexo g && hexo d

# deploy git
host=$(git status | awk -F\' '{print $2}' | awk -F/ '{print $1}' | sed -n 2p)
branch=$(git status | awk -F\' '{print $2}' | awk -F/ '{print $2}' | sed -n 2p)
git add .
read -p "commit massage:" message
git commit -m "$message"
git push "$host" "$branch"
