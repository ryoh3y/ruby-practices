#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアを配列に変換
score = ARGV[0].gsub('X', '10, 0')
shots = score.split(',').map(&:to_i)
frames = shots.each_slice(2).to_a

# スコア計算
point = frames.take(10).each_with_index.sum do |frame, index|
  if index == 9
    frames.slice(9..).flatten.sum
  elsif frame.first == 10 # ストライク時の計算
    strike = frame.sum
    bonus = frames[index + 1].first
    if frames[index + 1].first == 10
      strike + bonus + frames[index + 2].first
    else
      strike + bonus + frames[index + 1].last
    end
  elsif frame.sum == 10 # スペア時の計算
    frame.sum + frames[index + 1].first
  else
    frame.sum
  end
end

puts point
