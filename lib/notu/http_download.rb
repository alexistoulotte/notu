module Notu

  module HttpDownload

    def self.get(url, options = {})
      uri = url.is_a?(URI) ? url : URI.parse(url)
      raise Error.new("Invalid URL: #{url.inspect}") unless uri.is_a?(URI::HTTP)
      Notu.logger.debug('Notu') { "GET #{url}" }
      options.reverse_merge!(max_redirects: 10, timeout: 10, max_retries: 3, retry_sleep: 2)
      connection = Net::HTTP.new(uri.host, uri.port)
      connection.open_timeout = options[:timeout]
      connection.read_timeout = options[:timeout]
      if uri.is_a?(URI::HTTPS)
        connection.use_ssl = true
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      connection.start do |http|
        http.request_get(uri.request_uri, (options[:headers] || {}).stringify_keys) do |response|
          begin
            response.value # raise if not success
          rescue Net::HTTPRetriableError
            raise NetworkError.new('Max redirects has been reached') if options[:max_redirects] < 1
            options[:max_redirects] -= 1
            return get(response['Location'], options)
          end
          return response.body
        end
      end
    rescue Timeout::Error, Zlib::BufError => e
      raise NetworkError.new(e) if options[:max_retries] < 1
      options[:max_retries] -= 1
      sleep(options[:retry_sleep])
      get(url, options)
    rescue => e
      raise NetworkError.new(e)
    end

  end

end
