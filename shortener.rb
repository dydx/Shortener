# shortener.rb - Josh Sandlin - 12/5/2010 - 6:19PM
# Simple url shortener with Sinatra and OpenKeyVal.org

require 'rubygems'
require 'sinatra'
require 'flyingv'
require 'digest/md5'

# Some basic configurations
set :public, File.dirname(__FILE__) + '/static'
set :views, File.dirname(__FILE__) + '/views'

# some basic functions for setting and getting key-val pairs
