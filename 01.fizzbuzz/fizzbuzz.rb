puts "What number do you want to count?"
count = 20 # カウントしたい回数
  
# FizzBuzzの判定
(1..count.to_i).each do |x| # Rangeオブジェクトを使ってcountの数まで１ずつ繰り返す
  if x % 3 == 0 && x % 5 == 0 # ３の倍数かつ５の倍数の場合
    puts "FizzBuzz"
  elsif x % 3 == 0 # ３の倍数の場合
    puts "Fizz"
  elsif x % 5 == 0 # ５の倍数の場合
    puts "Buzz"
  else
    puts x
  end
end
