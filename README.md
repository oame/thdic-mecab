# 東方MeCab辞書 第四版

maintainer: おおあめ

license: -> LICENSE.md

## Requirements
* MeCab 0.994
* Ruby 1.9.x
* NKF
* bzip2
* wget

## Installation
	$ bundle install
	$ ./build.sh
	# 辞書が自動で作成されます => pkg/thdic-mecab.dic

## Usage
	$ mecab -u pkg/thdic-mecab.dic
	椛さん
	椛	名詞,固有名詞,人名,名,*,*,椛,モミジ,モミジ,東方Project
	さん	名詞,接尾,人名,*,*,*,さん,サン,サン
	EOS
	椛の紅葉
	椛	名詞,一般,*,*,*,*,椛,モミジ,モミジ
	の	助詞,連体化,*,*,*,*,の,ノ,ノ
	紅葉	名詞,サ変接続,*,*,*,*,紅葉,コウヨウ,コーヨー
	EOS

## Overview
* pack_dict.rb - 語彙ファイルを一つに纏めます
* build.sh - 辞書作成を自動化したシェルスクリプト
* LICENSE.md - ライセンス
* README.md - これ
* pkg/thdic-mecab.dic - 生成済みの東方MeCab辞書