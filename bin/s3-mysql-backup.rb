#!/usr/bin/env ruby

require 'rubygems'


#require 'ruby-debug'
$:.unshift File.expand_path("../../lib", __FILE__)

require 's3-mysql-backup'

def die(msg)
  puts "ERROR: #{msg}"
  exit 1
end

def usage
  puts <<-END
Usage: s3-mysql-backup DATABASE CONFIG_FILE

END
  exit 1
end

def process_options

  usage unless ARGV.size == 2
  $DATABASE         = ARGV.first
  $CONFIG_FILE_NAME = File.expand_path(ARGV.last)
end

def main
  process_options

  die "Missing configuration file." unless File.exists?($CONFIG_FILE_NAME)

  S3MysqlBackup.new($DATABASE, $CONFIG_FILE_NAME).run
end

main