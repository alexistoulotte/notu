module Notu

  module JsonDocument

    def self.get(url, options = {})
      JSON.parse(HttpDownload.get(url, options))
    end

  end

end
