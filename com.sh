#!/bin/bash/
echo "提交改变"
git add ./
echo "提交注释"
git commit -m "Hello World"
echo "推送到远程仓库"
git push -u origin master
