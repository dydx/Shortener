# shortener.rb - Josh Sandlin - 12/5/2010 - 6:19PM
# Simple url shortener with Sinatra and OpenKeyVal.org

require 'rubygems'
require 'sinatra'
require 'flyingv'
require 'digest/md5'

# Some basic configurations. Edit as needed
set :public, File.dirname(__FILE__) + '/static'
set :views, File.dirname(__FILE__) + '/views'
HOST = "localhost"
PORT = 4567

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

# render the frontend all nice and purdy
get '/' do
  erb :index
end

post '/' do |url|
  key = gen_key( url )
  send( key, url )
  @short_url = "http://#{HOST}:#{PORT}/#{key}"
  erb :submitted
end

get '/:url' do |hash_key|
  original_url = get( hash_key )
  redirect original_url
end
