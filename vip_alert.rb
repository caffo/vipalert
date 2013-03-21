# encoding: UTF-8

$LOAD_PATH << "./lib"

require 'rubygems'
require 'bundler/setup'
require 'yaml'

require 'vip_alert'


VipAlert::Inbox.process_inbox!