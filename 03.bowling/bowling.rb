#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアを配列に変換
score = ARGV[0].gsub('X', '10, 0')
shots = score.split(',').map(&:to_i)
frames = shots.each_slice(2).to_a

# スコア計算
point = frames.take(10).each_with_index.sum do |frame, index|
  frame_sum = frame.sum
  next_frame_first_roll = frames[index + 1]&.first
  frame_sum + if index == 9
                frames.slice(9..).flatten.sum - frame_sum
              elsif frame.first == 10 # ストライク時の計算
                next_frame_first_roll + if frames[index + 1].first == 10
                                          frames[index + 2].first
                                        else
                                          frames[index + 1].last
                                        end
              elsif frame_sum == 10 # スペア時の計算
                frames[index + 1].first
              else
                0
              end
end

puts point
