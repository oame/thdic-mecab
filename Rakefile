#!/usr/bin/env rake

require "MeCab"
require "nkf"

IPADIC = "mecab-ipadic-2.7.0-20070801"
IPADIC_ARC = "#{IPADIC}.tar.gz"
IPADIC_MODEL = "mecab-ipadic-2.7.0-20070801.model"
IPADIC_MODEL_ARC = "#{IPADIC_MODEL}.bz2"

task :pack_dict do
  files = [
    "Noun.csv",
    "Noun.name.csv",
    "Noun.title.csv",
    "Noun.org.csv",
    "Noun.place.csv",
    "Adverb.csv",
    "Verb.csv",
    "Adnominal.csv"
  ]
  lines = []
  files.each do |file|
    File.open(File.join("../", file), "r").each_line do |line|
      lines << line.strip
    end
  end

  File.open("thdic-mecab.csv", "w") do |f|
    lines.each do |line|
      f.puts line
    end
  end
end

desc "Build dict"
task :build do
  Dir.mkdir("tmp") unless FileTest.exists? "tmp"
  Dir.chdir("tmp")
  
  Rake::Task["pack_dict"].invoke
  system "wget http://mecab.googlecode.com/files/#{IPADIC_ARC}" unless FileTest.exists? IPADIC_ARC
  system "wget http://mecab.googlecode.com/files/#{IPADIC_MODEL_ARC}" unless FileTest.exists? IPADIC_MODEL_ARC
  
  system "tar zxvf #{IPADIC_ARC}"
  system "bunzip2 -d #{IPADIC_MODEL_ARC}"
  system "nkf --overwrite -Ew #{IPADIC}/*"
  system "nkf --overwrite -Ew #{IPADIC_MODEL}"
  
  system "cp ../mecab-ipadic-model.patch ./"
  system "patch < mecab-ipadic-model.patch"
  
  Dir.chdir(IPADIC)
  mecab_libexecdir = `mecab-config --libexecdir`.strip
  system "#{mecab_libexecdir}/mecab-dict-index -t utf-8 -f utf-8"
  Dir.chdir("../")
  system "#{mecab_libexecdir}/mecab-dict-index -m mecab-ipadic-2.7.0-20070801.model -d mecab-ipadic-2.7.0-20070801 -u thdic-mecab.dic -f utf-8 -t utf-8 thdic-mecab.csv"
  Dir.chdir("../")
  Dir.mkdir("pkg") unless FileTest.exists? "pkg"
  system "cp tmp/thdic-mecab.dic pkg"
  system "rm -rf tmp"
end

task :install do
  mecab_dicdir = `mecab-config --dicdir`.strip
  if FileTest.exists? "pkg/thdic-mecab.dic"
    puts "Installing thdic-mecab ..."
    Dir.mkdir("#{mecab_dicdir}/thdic") unless FileTest.exists? "#{mecab_dicdir}/thdic"
    system "cp pkg/thdic-mecab.dic #{mecab_dicdir}/thdic"
    puts "Done => #{mecab_dicdir}/thdic/thdic-mecab.dic"
    puts "-"*40
    puts "Also add following line to your 'mecabrc' to enable this dict always."
    puts "userdic = #{mecab_dicdir}/thdic/thdic-mecab.dic"
    puts "-"*40
    print "...or add line to your 'mecabrc' automatically? [y/n]: "
    if STDIN.gets.strip == "y"
      mecab_confdir = `mecab-config --sysconfdir`.strip
      system "echo 'userdic = #{mecab_dicdir}/thdic/thdic-mecab.dic' >> #{mecab_confdir}/mecabrc"
    end
  else
    puts "thdic [pkg/thdic-mecab.dic] not found! Run first 'rake build'"
  end
end