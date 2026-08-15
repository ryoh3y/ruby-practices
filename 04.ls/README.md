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

## 課題 04
### 期待要件
- ターミナルでのlsコマンドを実行した出力結果を```ruby ls.rb -l```を実行したらファイルのパーミッション情報、所有者、作成日時の情報が出力される。

期待出力（オプションなし）
```
> ruby ls.rb
my_bloody_valentine.rb		primal_scream.rb		slowdive.rb			the_jesus_and_mary_chain.rb
oasis.rb			ride.rb				teenage_fanclub.rb

```

期待出力（オプションあり）
```
> ruby ls.rb -l
total 0
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 my_bloody_valentine.rb
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 oasis.rb
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 primal_scream.rb
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 ride.rb
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 slowdive.rb
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 teenage_fanclub.rb
-rw-r--r--@ 1 ryoheiharada  staff  0  3月 16 20:36 the_jesus_and_mary_chain.rb

```

#### 情報の項目
```
-rw-r--r--  1 ryoheiharada  staff  0  3月 16 20:36 oasis.rb

1. ファイル種別 + パーミッション
2. ハードリンク数
3. 所有者（owner/user）
4. 所有グループ（group）
5. ファイルサイズ（bytes）
6. 最終更新日時
7. ファイル名
```

#### ファイル情報の取得
メソッド [singleton method File.stat](https://docs.ruby-lang.org/ja/latest/method/File/s/stat.html) ```File.stat('File Path')``` で ファイルに紐づく情報を取得する。

```method File.stat```の理解

irbで取得した内容
```
irb(main):013> files_info = File.stat('primal_scream.rb')
=> 
#<File::Stat
...
irb(main):014> p files_info
#<File::Stat dev=0x1000012, ino=72907435, mode=0100644, nlink=1, uid=501, gid=20, rdev=0x0, size=0, blksize=4096, blocks=0, atime=2026-03-16 20:36:34.321020838 +0900, mtime=2026-03-16 20:36:34.321020838 +0900, ctime=2026-05-03 13:21:23.9328346 +0900, birthtime=2026-03-16 20:36:34.321020838 +0900>
=> 
#<File::Stat
 dev=0x1000012,
 ino=72907435,
 mode=0100644 (file rw-r--r--),
 nlink=1,
 uid=501 (ryoheiharada),
 gid=20 (staff),
 rdev=0x0 (0, 0),
 size=0,
 blksize=4096,
 blocks=0,
 atime=2026-03-16 20:36:34.321020838 +0900 (1773660994),
 mtime=2026-03-16 20:36:34.321020838 +0900 (1773660994),
 ctime=2026-05-03 13:21:23.9328346 +0900 (1777782083)>
irb(main):015> exit

```

```
dev         デバイス番号(ファイルシステム)
dev_major   dev の major 番号部
dev_minor   dev の minor 番号部
ino         i-node 番号
mode        ファイルモード
nlink       ハードリンクの数
uid         オーナーのユーザID
gid         オーナーのグループID
rdev        デバイスタイプ(スペシャルファイルのみ)
rdev_major  rdev の major 番号部
rdev_minor  rdev の minor 番号部
size        ファイルサイズ(バイト単位)
blksize     望ましいI/Oのブロックサイズ
blocks      割り当てられているブロック数
atime       最終アクセス時刻
mtime       最終更新時刻
ctime       最終状態変更時刻(状態の変更とは chmod などによるもので、Unix では i-node の変更を意味します)
```

今回、File.statで取得して必要になる情報は、```mode, nlink, uid, size, mtime```の5項目とファイル名。
```total```を出すためには```blocks```を取得して足し合わせた結果を出す。

