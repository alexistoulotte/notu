module Notu

  module HttpDownload

    def self.get(url, options = {})
      uri = url.is_a?(URI) ? url : URI.parse(url)
      raise "Invalid URL: #{url.inspect}" unless uri.is_a?(URI::HTTP)
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
            raise 'Max redirects has been reached' if options[:max_redirects] < 1
            options[:max_redirects] -= 1
            return get(response['Location'], options)
          end
          return response.body
        end
      end
    rescue Net::ReadTimeout, TimeoutError, Timeout::Error, Zlib::BufError => exception
      raise NetworkError.new(exception) if options[:max_retries] < 1
      options[:max_retries] -= 1
      sleep(options[:retry_sleep])
      get(url, options)
    rescue => exception
      raise NetworkError.new(exception)
    end

  end

end
