# lsコマンドを作る

## 課題 01
### 期待要件
- ターミナルでのlsコマンドを実行した出力結果を```ruby ls.rb```を実行したら出力できるようにする。
- lsコマンドとは違うポイント
  - ターミナルのウィンドサイズには依存しない
  - 提出時の出力のカラム数は３列にする
  - 列数は後から変更ができるように変数で管理する
- 表示のスタイルのルール
  - 左上から縦詰め
  - ファイルの順番 0~9, a~xyz （ソートルールは確認したい）
  - プラクティスでは横に最大3カラムを維持して表示する（実際のlsコマンドはターミナルWindowの幅によってカラムの数は可変する）
  - 拡張子も表示
  - カラム位置開始位置は行で全て同じ（カラム幅は全て共通）
  - ディレクトリとファイルの区別はなく全て出力
  - 隠しファイルは表示しない

期待出力
```
> ruby ls.rb
a.rb  d.rb  g.rb
b.rb  e.rb  ls.rb
c.rb  f.rb
```

## 課題 02
### 期待要件
- ターミナルでのlsコマンドを実行した出力結果を```ruby ls.rb -a```を実行したら隠しファイルが出力結果に出るようになる
  - オプションありとなしそれぞれの出力ができるようになる
  - ```-a```以外のオプションも今後追加されるため複数のオプションを追加できるようにする

期待出力（オプションなし）
```
> ruby ls.rb
my_bloody_valentine.rb      ride.rb                     the_jesus_and_mary_chain.rb
oasis.rb                    slowdive.rb                                            
primal_scream.rb            teenage_fanclub.rb    
```

期待出力（オプションあり）
```
> ruby ls.rb -a
.                           oasis.rb                    teenage_fanclub.rb         
..                          primal_scream.rb            the_jesus_and_mary_chain.rb
.DS_Store                   ride.rb                                                
my_bloody_valentine.rb      slowdive.rb    
```

## 課題 0３
### 期待要件
- ターミナルでのlsコマンドを実行した出力結果を```ruby ls.rb -r```を実行したらファイルが逆順になった出力結果が出るようになる
  - オプションありとなしそれぞれの出力ができるようになる

期待出力（オプションなし）
```
> ruby ls.rb
my_bloody_valentine.rb      ride.rb                     the_jesus_and_mary_chain.rb
oasis.rb                    slowdive.rb                                            
primal_scream.rb            teenage_fanclub.rb    
```

期待出力（オプションあり）
```
> ruby ls.rb -r
the_jesus_and_mary_chain.rb ride.rb                     my_bloody_valentine.rb      
teenage_fanclub.rb          primal_scream.rb            
slowdive.rb                 oasis.rb                    
```
