# encoding: UTF-8

require 'singleton'
require 'logger'
require 'date'
require 'twilio-ruby'
require 'uri'
require 'net/http'
require 'net/https'
require 'rexml/document'


require 'vip_alert/config'
require 'vip_alert/account'
require 'vip_alert/settings'
require 'vip_alert/inbox'