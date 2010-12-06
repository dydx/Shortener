# shortener.rb - Josh Sandlin - 12/5/2010 - 6:19PM
# Simple url shortener with Sinatra and OpenKeyVal.org

# "THE BEER-WARE LICENSE" (Revision 43):
# <joshua.sandlin@gmail.com> wrote this file. As long as you retain this
# notice you can do whatever you want with this stuff. If we meet some day,
# and you think this stuff is worth it, you can buy me a beer in return.
#   ~Josh Sandlin

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

def send_key_val( key, val )
  FlyingV.post( key, val )
end

def get_by_key( key )
  FlyingV.get( key )
end

# render the frontend all nice and purdy
get '/' do
  erb :index
end

post '/' do
  url = params[:url]
  key = gen_key( url )
  send_key_val( key, url )
  @short_url = "http://#{HOST}:#{PORT}/#{key}"
  erb :submitted
end

get '/:url' do |hash_key|
  original_url = get_by_key( hash_key )
  redirect original_url
end
