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
def gen_key( string )
  md5 = Digest::MD5.hexdigest( string )
  return md5[0, 3] + md5[29, 31]
end

def send( key, val )
  FlyingV.post( key, val )
end

def get( key )
  FlyingV.get( key )
end
