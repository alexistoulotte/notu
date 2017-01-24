require 'active_support'
require 'active_support/core_ext'
require 'byebug' if ENV['DEBUGGER']
require 'cgi'
require 'net/https'
require 'nokogiri'

lib_path = "#{__dir__}/notu"

module Notu

  mattr_accessor :logger
  self.logger = Logger.new(nil)

end

require "#{lib_path}/error"
require "#{lib_path}/network_error"
require "#{lib_path}/parse_error"

require "#{lib_path}/html_document"
require "#{lib_path}/http_download"
require "#{lib_path}/library"
require "#{lib_path}/listing"
require "#{lib_path}/loved_tracks"
require "#{lib_path}/most_played_tracks"
require "#{lib_path}/played_tracks"
require "#{lib_path}/track"
