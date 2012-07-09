#!/usr/bin/env ruby
# coding: utf-8

require "MeCab"
require "nkf"
require "pp"

files = [
  "Noun.csv",
  "Noun.name.csv",
  "Noun.title.csv",
  "Noun.org.csv",
  "Noun.place.csv",
  "Prefix.csv",
  "Verb.csv"
]
lines = []
files.each do |file|
  File.open(file, "r").each_line do |line|
    lines << line.strip
  end
end

File.open("thdic-mecab.csv", "w") do |f|
  lines.each do |line|
    f.puts line
  end
end