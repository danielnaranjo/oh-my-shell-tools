#!/usr/bin/env bash
PROJECT="starter-$(date +'%d%m')"
mkdir $PROJECT
cd $PROJECT

echo "Downloading assets"
#git clone https://github.com/danielnaranjo/seed-project-base.git demo
#cp -a demo/assets assets
#rm -rf demo

echo "Download codeigniter-starter"
git clone https://github.com/danielnaranjo/codeigniter-starter.git base
cp -a base/. ./
rm -rf base
