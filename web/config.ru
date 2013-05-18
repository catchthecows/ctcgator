require 'rubygems'
require 'bundler'
Bundler.require
  
require File.expand_path(File.dirname(__FILE__) + '/mainsrv')

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new('log/sinatra.log', 'a')
$stderr.reopen(log)
$stderr.sync = true

run CTCGator
