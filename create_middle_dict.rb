#!/usr/bin/env ruby
# coding: utf-8

require "nkf"
require "pp"

def average_cost(file)
  puts "Loading #{file} ..."
  tbl = File.open(file, "r").read
  
  costs = {}
  tbl.each_line do |line|
    ustr = NKF.nkf("-w", line)
    item = ustr.split("(").map{|s|s.split(")")}[5][0].split(" ")
    len = item[0].size
    costs[len] ||= []
    costs[len] << item[1]
  end

  ave_costs = {}
  costs.each do |len, cost|
    ave_costs[len] = cost.inject(0){|x,y| x + y.to_i}/cost.size
  end
  
  return ave_costs
end

$cost_table = {
  "noun" => average_cost("ipadic/Noun.dic"),
  "proper_noun" => average_cost("ipadic/Noun.proper.dic"),
  "name" => average_cost("ipadic/Noun.name.dic"),
  "verb" => average_cost("ipadic/Verb.dic"),
  "other"=> average_cost("ipadic/Others.dic")
}

def near_number(pos, num)
  i = []
  $cost_table[pos].keys.each_cons(2) do |x,y|
    i << ((num-y)/x.to_f)
  end
  i = i.reverse
  near = i.map{|s|s.abs}.min
  near_index = i.map{|s|s.abs}.index(near)
  return near_index
end

def regular_pos_name(pos)
  pos_name = {
    "固有名詞" => "proper_noun",
    "名詞" => "noun",
    "人名" => "name",
    "姓"  => "name",
    "名"  => "name",
    "形容動詞" => "verb",
    "さ変名詞" => "noun",
    "助数詞"  => "other"
  }
  rpos = pos_name[pos] || "proper_noun"
  return rpos
end

def mecab_pos_conj_string(pos)
  pos_array = {
    "人名" => ["名詞", "固有名詞", "人名", "一般"],
    "姓" => ["名詞", "固有名詞", "人名", "姓"],
    "名" => ["名詞", "固有名詞", "人名", "名"],
    "名詞" => ["名詞", "一般"],
    "固有名詞" => ["名詞", "固有名詞", "一般"],
    "地名" => ["名詞","固有名詞", "地域", "一般"],
    "接頭詞" => ["接頭詞"],
    "ら行五段" => ["動詞", "自立"],
    "一段動詞" => ["動詞", "自立"]
  }
  pos_a = pos_array[pos].join(",") + ",*"*(4 - pos_array[pos].size) rescue "*,*,*,*"
  
  conj_array = {
    "ら行五段" => ["五段・ラ行", "未然形"],
    "一段動詞" => ["一段", "連用形"]
  }
  conj_a = conj_array[pos].join(",") + ",*"*(2 - conj_array[pos].size) rescue "*,*"
  
  return [pos_a, conj_a].join(",")
end

def costtable_for_pos(pos)
  return $cost_table[regular_pos_name(pos)]
end

def near_cost(pos, keyword)
  tbl = costtable_for_pos(pos)
  ncost = tbl[near_number(regular_pos_name(pos), keyword.size)]
  return ncost
end

year = /[0-9]{4}/

dict = ARGV[0] || "output.mdic"

File.open(dict, "a") do |f|
STDIN.each_line do |line|
  item = line.strip.split(",")
  next unless item.size == 3
  keyword = item[1]
  reading = NKF.nkf('-w --katakana', item[0])
  pos = item[2]
  ncost = near_cost(pos, keyword)
  pc_str = mecab_pos_conj_string(pos)
  f.puts "%s,0,0,%s,%s,%s,%s,%s,東方Project" % [keyword, ncost, pc_str, keyword, reading, reading]
end
end