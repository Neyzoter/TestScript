#!/bin/bash

# Jobnote
echo "Start git jobnote..."
cd ~/code/jobnote
git add .
git commit -m "quick git"
git push
echo "Git jobnote end..."

# aiot
echo "Start git aiot..."
cd ~/code/java/aiot
git add .
git commit -m "quick git"
git push
echo "Git aiot end..."

# Algorithm_OJ
echo "Start git Algorithm_OJ..."
cd ~/code/java/Algorithm_OJ
git add .
git commit -m "quick git"
git push
echo "Git Algorithm_OJ end..."

# spring-example
echo "Start git spring-example..."
cd ~/code/java/spring-example
git add .
git commit -m "quick git"
git push
echo "Git spring-example end..."

echo "[QUICKGIT END]"
