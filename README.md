東方MeCab辞書第二版
------------------
author: おおあめ

license: -> LICENSE.md

Required environment
------------------
* MeCab
* Ruby 1.9.x

Quick installation
------------------
run ./make.sh

Overview
------------------
* compile_dict.rb - csv形式の辞書をdic形式に変換します
* create_middle_dict.rb - thdic/*の語彙データをMeCabフォーマットのcsvに変換します
* thdic/* - 語彙データ
* make.sh - 辞書作成を自動化したシェルスクリプト
* ipadic/* IPA辞書
* LICENSE.md - ライセンス
* README.md - これ