#!/usr/bin/env ruby
# coding: utf-8

require "pp"

mecab_dicdir = `mecab-config --dicdir`.strip
mecab_libexecdir = `mecab-config --libexecdir`.strip
ipadic_path = "#{mecab_dicdir}/ipadic"

raise ArgumentError, "Can't find input file. run => $ compile_dict.rb input.csv" unless ARGV[0]

input  = ARGV[0]
output = ARGV[1] || "thdic-mecab.dic"
puts input,output

pp exec("#{mecab_libexecdir}/mecab-dict-index -d #{ipadic_path} -u #{output} -f utf8 -t utf8 #{input}")