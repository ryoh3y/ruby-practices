#!/usr/bin/env ruby
# frozen_string_literal: true

# Model
# - ファイル名取得 👉 実装済み
# - 隠しファイル制御 👉 実装済み
# - ソート 👉 実装済み
# - カラム用再配置（縦詰め）👉 実装済み

class FileList
  # ファイル名取得
  def files
    Dir.entries('.')
  end

  # 隠しファイルの削除
  def visible(files, show_all: false)
    return files if show_all

    files.reject { |item| item.start_with?('.') }
  end

  # ソートとカラム用再配置
  def sort(files, col)
    sorted = files.sort # ファイル名をアルファベット順にソート
    row_count = (sorted.length.to_f / col).ceil # 行数を計算
    rows = sorted.each_slice(row_count).to_a
    max_cols = rows.map(&:length).max # 行の最大数を取得
    rows.each do |row|
      row.fill(nil, row.length...max_cols) # nilで埋める
    end
    cols = rows.transpose # 行と列を入れ替える
    cols.each(&:compact!) # nilを削除
    cols
  end
end

# View
# - 整形（幅揃え）👉 実装済み
# - 出力（puts）👉 実装済み

class View
  def render(rows)
    max_width = rows.flatten.compact.map(&:length).max
    rows.each do |row|
      puts row.map { |item| item.ljust(max_width) }.join(' ')
    end
  end
end

# Controller
# - Model呼び出し 👉 実装済み
# - カラム数の定義 👉 実装済み

class Controller
  def initialize
    @model = FileList.new
    @view = View.new
  end

  def run
    col = 3
    files = @model.files
    files = @model.visible(files)
    files = @model.sort(files, col)

    @view.render(files)
  end
end

Controller.new.run if __FILE__ == $PROGRAM_NAME

# 処理の流れ
# 1. 本プログラムのファイル名が実行されたときにControllerというインスタンスを作成し、runメソッドを呼び出す
# 2. Controllerのrunメソッド内で、FileListクラスとViewクラスのインスタンスを作成する
# 3. FileListクラスのget_filesメソッドを呼び出して、ディレクトリのファイル名を取得する
# 4. FileListクラスのvisibleメソッドを呼び出して、隠しファイルを除外する
# 5. FileListクラスのsortメソッドを呼び出して、ファイル名をソートする
# 6. sortメソッドでは、ソートされたファイル名を３列に分割して、縦詰めの形式に再配置する
# 7. Viewクラスのrenderメソッドを呼び出す。renderメソッドでは、ファイルの名の最大文字数を計算して、各ファイル名をその幅+１スペース分だけプラスして左寄せにして出力する
