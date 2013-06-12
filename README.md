# 東方MeCab辞書 v4.1

東方Projectに登場する人物や動詞、形容詞等をMeCabで扱えるようにするための辞書です。

maintainer: おおあめ

license: -> LICENSE.md

## Requirements
* MeCab 0.994+
* Ruby 1.9.x+
* Rake
* NKF
* bzip2
* wget

## Installation
```bash
$ rake install #=> 辞書がインストールされます
```

## Usage
```bash
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
```

## Build Dictionary
```bash
$ rake build #=> 辞書が作成されます [pkg/thdic-mecab.dic]
```

## Overview
* Rakefile - 自動処理を記述したファイル
* LICENSE.md - ライセンス
* CHANGELOG.md - 変更履歴
* README.md - これ
* pkg/thdic-mecab.dic - 生成済みの東方MeCab辞書