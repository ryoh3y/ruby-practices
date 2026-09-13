#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

PERMISSION_MAP = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}

options = {}

OptionParser.new do |option|
  option.on('-a') do
    options[:all] = true
  end
  option.on('-r') do
    options[:reverse] = true
  end
  option.on('-l') do
    options[:long_format] = true
  end
end.parse!

class Ls
  def initialize(options)
    @options = options
  end

  def run
    files = fetch_files
    files = @options[:all] ? files : filter_visible_files(files)
    files = files.sort
    files = @options[:reverse] ? files.reverse : files
    files = @options[:long_format] ? long_format(files) : files
    rows = format_columns(files)

    if @options[:long_format]
      output_long_format(files)
    else
      output(rows)
    end
  end

  def fetch_files
    Dir.entries('.')
  end

  def filter_visible_files(files)
    files.reject { |file| file.start_with?('.') }
  end

  def format_columns(files)
    col = COLUMN_COUNT
    row_count = (files.length.to_f / col).ceil
    rows = files.each_slice(row_count).to_a
    max_cols = rows.map(&:length).max
    rows.each do |row|
      row.fill(nil, row.length...max_cols)
    end
    rows.transpose
  end

  def long_format(files)
    files.map do |file|
      stat = File.stat(file)
      {
        permissions: mode_string(stat.mode.to_s(8)),
        nlinks: stat.nlink,
        uid: stat.uid,
        gid: stat.gid,
        size: stat.size,
        mtime: stat.mtime,
        name: file,
        blocks: stat.blocks
      }
    end
  end

  def mode_string(mode_str)
    permissions = mode_str.slice(-3, 3)

    user  = PERMISSION_MAP[permissions[0]]
    group = PERMISSION_MAP[permissions[1]]
    other = PERMISSION_MAP[permissions[2]]

    user + group + other
  end

  def output(rows)
    max_width = rows.flatten.compact.map(&:length).max
    rows.each do |row|
      puts row.map { |item| item.to_s.ljust(max_width) }.join(' ')
    end
  end

  def output_long_format(files)
    total_blocks = files.sum { |file| file[:blocks] }
    puts "total #{total_blocks}"
    files.each do |file|
      puts "#{file[:permissions]} #{file[:nlinks]} #{file[:uid]} #{file[:gid]} #{file[:size]} #{file[:mtime].strftime('%b %d %H:%M')} #{file[:name]}"
    end
  end
end

Ls.new(options).run if __FILE__ == $PROGRAM_NAME
