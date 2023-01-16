require 'active_support'
require 'active_support/core_ext'
require 'byebug' if ENV['DEBUGGER']
require 'cgi'
require 'net/https'

lib_path = "#{__dir__}/notu"

module Notu

  mattr_accessor :logger, instance_writer: false, instance_reader: false
  self.logger = Logger.new(nil)

end

require "#{lib_path}/error"
require "#{lib_path}/network_error"
require "#{lib_path}/parse_error"

require "#{lib_path}/api"
require "#{lib_path}/http_download"
require "#{lib_path}/json_document"
require "#{lib_path}/loved_tracks"
require "#{lib_path}/recent_tracks"
require "#{lib_path}/top_tracks"
require "#{lib_path}/track"
require "#{lib_path}/user_api"
