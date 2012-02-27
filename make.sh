#!/bin/sh

rm output.mdic
rm thdic-mecab.dic
cat thdic/Noun.txt | ./create_middle_dict.rb
cat thdic/Noun.name.txt | ./create_middle_dict.rb
# フルネーム辞書。必要ならコメントアウトしてください。
#cat thdic/Noun.name.full.txt | ./create_middle_dict.rb
cat thdic/Noun.title.txt | ./create_middle_dict.rb
cat thdic/Noun.place.txt | ./create_middle_dict.rb
cat thdic/Prefix.txt | ./create_middle_dict.rb
cat thdic/Verb.txt | ./create_middle_dict.rb
./compile_dict.rb output.mdic