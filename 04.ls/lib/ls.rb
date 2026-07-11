#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_COUNT = 3

options = {}

OptionParser.new do |option|
  option.on('-a') do
    options[:all] = true
  end
end.parse!

class Ls
  def initialize(options)
    @options = options
  end

  def run
    files = fetch_files
    files = filter_visible_files(files) unless @options[:all]
    rows = format_columns(files)

    output(rows)
  end

  def fetch_files
    Dir.entries('.')
  end

  def filter_visible_files(files)
    files.reject { |file| file.start_with?('.') }
  end

  def format_columns(files)
    col = COLUMN_COUNT
    sorted_files = files.sort
    row_count = (sorted_files.length.to_f / col).ceil
    rows = sorted_files.each_slice(row_count).to_a
    max_cols = rows.map(&:length).max
    rows.each do |row|
      row.fill(nil, row.length...max_cols)
    end
    rows.transpose
  end

  def output(rows)
    max_width = rows.flatten.compact.map(&:length).max
    rows.each do |row|
      puts row.map { |item| item.to_s.ljust(max_width) }.join(' ')
    end
  end
end

Ls.new(options).run if __FILE__ == $PROGRAM_NAME
