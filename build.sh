#!/bin/sh

mkdir work
ruby pack_dict.rb
mv thdic-mecab.csv work
cd work
wget http://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz
wget http://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.model.bz2
tar zxvf mecab-ipadic-2.7.0-20070801.tar.gz
bunzip2 -d mecab-ipadic-2.7.0-20070801.model.bz2
nkf --overwrite -Ew mecab-ipadic-2.7.0-20070801/*
nkf --overwrite -Ew mecab-ipadic-2.7.0-20070801.model
cp ../mecab-ipadic-model.patch ./
#mv mecab-ipadic-2.7.0-20070801.model mecab-ipadic-2.7.0-20070801.model.orig
patch < mecab-ipadic-model.patch
cd mecab-ipadic-2.7.0-20070801
`mecab-config --libexecdir`/mecab-dict-index -t utf-8 -f utf-8
cd ../
`mecab-config --libexecdir`/mecab-dict-index -m mecab-ipadic-2.7.0-20070801.model -d mecab-ipadic-2.7.0-20070801 -u thdic-mecab.dic -f utf-8 -t utf-8 thdic-mecab.csv
cd ../
mkdir pkg
cp work/thdic-mecab.dic pkg
rm -rf work