#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアを配列に変換
score = ARGV[0].gsub('X', '10, 0')
shots = score.split(',').map(&:strip).map(&:to_i)
frames = shots.each_slice(2).to_a

# スコア計算
point = 0

frames.each_with_index do |frame, index|
  point +=
    if index == 9
      frames.slice(9..-1).flatten.sum # 10フレーム目は追加点なしで合計を計算
    elsif frame.first == 10 # ストライク時の得点計算
      if frames[index + 1].first == 10 
        10 + frames[index + 1].first + frames[index + 2].first
      else
        10 + frames[index + 1].sum
      end
    elsif frame.sum == 10 # スペア時の得点計算
      frame.sum + frames[index + 1].first
    else
      frame.sum
    end
  break if index == 9
end

puts point
