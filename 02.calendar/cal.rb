#!/usr/bin/env ruby
require 'date'
require 'optparse'

# 今日の日付を取得
today = Date.today
year  = today.year
month = today.month

# オプションがあった場合の条件分岐
options = {}
opt = OptionParser.new

opt.on('-m VAL') do |m|
  options[:month] = m.to_i
end
opt.on('-y VAL') do |y|
  options[:year] = y.to_i
end

opt.parse!(ARGV)

if options[:month]
  month = options[:month]
  if options[:year]
    year = options[:year]
  end
else
  if options[:year]
    puts "ERROR!"
  end
end

# 特定された月を1日から月末日を特定
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

# 曜日の取得
today_wday = today.wday

# カレンダー出力
puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土 "

# 今月の日付をプリントする
print "   " * first_day.wday

(first_day...last_day).each do |date|
  print date.day.to_s.rjust(2) + " "
  if date.wday == 6
    puts "\n"
  end
end

print "\n"
