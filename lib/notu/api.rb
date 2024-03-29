module Notu

  class Api

    DEFAULT_API_KEY = '91f5d6a201de58e0c0a0d858573dddf0'.freeze
    FORMAT = 'json'.freeze
    HOST = 'ws.audioscrobbler.com'.freeze
    VERSION = '2.0'.freeze

    attr_reader :api_key

    def initialize(api_key: DEFAULT_API_KEY)
      @api_key = api_key.try(:squish).presence || raise(Error.new('API key must be specified'))
    end

    def url(params = {})
      params = (params || {}).symbolize_keys
      params.merge!(api_key:, format: FORMAT)
      query_string = params.map { |name, value| "#{CGI.escape(name.to_s)}=#{CGI.escape(value.to_s)}" }.join('&')
      "https://#{HOST}/#{VERSION}?#{query_string}"
    end

  end

end
