#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアを配列に変換
score = ARGV[0].gsub('X', '10, 0')
shots = score.split(',').map(&:strip).map(&:to_i)
frames = shots.each_slice(2).to_a

print frames

# スコア計算
point = 0

frames.each_with_index do |frame, index|
  point +=
    if index == 9
      frames.slice(9..-1).flatten.sum # 10フレーム目は追加点なしで合計を計算
    elsif frame.first == 10
      if frames[index + 1].first == 10 
        10 + frames[index + 1].first + frames[index + 2].first # ダブルストライク時の得点計算：現在のフレーム(10) + 次のフレームの1投目 + 再次のフレームの1投目
      else
        10 + frames[index + 1].sum # 通常のストライク時の得点計算：現在のフレーム(10) + 次のフレームの2投分
      end
    elsif frame.sum == 10
      frame.sum + frames[index + 1].first # スペア時の得点計算：現在のフレーム(10) + 次のフレームの1投目
    else
      frame.sum # 通常時の得点計算：現在のフレームの合計
    end
  break if index == 9 # 10フレーム目で計算終了
end

puts point

          #  if index == 9
          #    frames.slice(9..-1).flatten.sum
          #  elsif frame[0] == 10
          #    if index < 8 && frames[index + 1][0] == 10
          #      10 + 10 + frames[index + 2][0]
          #    else
          #      10 + frames[index + 1][0] + frames[index + 1][1]
          #    end
          #  elsif frame[0] + frame[1] == 10
          #    frame[0] + frame[1] + frames[index + 1][0]
          #  else
          #    frame.sum
          #  end

# puts point
