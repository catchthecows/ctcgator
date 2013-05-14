require 'rubygems'
require 'bundler'
Bundler.require
  
require File.expand_path(File.dirname(__FILE__) + '/mainsrv')

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new('log/sinatra.log', 'a')
$stdout.reopen(log)
#$stderr.reopen(log)
#$stderr.sync = true
$stdout.sync = true

run CTCGator
