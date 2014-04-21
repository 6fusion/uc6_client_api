module UC6
  ##
  # The UC6::Client class caches authentication tokens and exposes methods to
  # make individual HTTP requests to the 6Fusion REST API.
  #
  class Client

    attr_reader :auth_token
    attr_reader :agent

    # 1.8.7 doesn't have the RUBY_ENGINE constant
    if defined?(RUBY_ENGINE)
      engine = RUBY_ENGINE
    else
      engine = 'ruby'
    end

    HTTP_HEADERS = {
      'Accept' => 'application/json',
      'Accept-Charset' => 'utf-8',
      'User-Agent' => "uc6-ruby/#{UC6::VERSION} (#{engine}/#{RUBY_PLATFORM} #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})",
    }

    DEFAULTS = {
      :host => 'http://console.6fusion.com:443',
      :timeout => 30,
      :api_prefix => '/api/v1'
    }

    def initialize(options = {})
      @conn = Faraday.new do |builder|
        builder.adapter Faraday.default_adapter
        builder.use Faraday::Response::ParseJson, :content_type => /\bjson$/
        builder.use Faraday::Response::RaiseError
      end
      @conn.headers = {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
      @request_options = {}
      @request_options.merge!(DEFAULTS)
      @request_options.merge!(options)
      @agent = HTTP_HEADERS['User-Agent']
    end

    def make_request(method, noun, sub_noun=nil, id=nil, body_data=nil)
      path = @request_options[:host] + @request_options[:api_prefix] + "/#{noun}" + (!id.nil? ? "/#{id}" : '') 
      path = path + (!sub_noun.nil? ? "/#{sub_noun}" : '') + (:auth_token ? "?auth_token=#{auth_token}" : '')

      response = @conn.send(method, path) do |req|
        req.body = body_data.to_json unless body_data.nil?
      end
      {:status => response.status, :result => response.body}
    end

    def sign_in(username, password)
      login = {:user => {:email => username, :password => password} }
      response = @conn.post @request_options[:host] do |req|
        req.body = login.to_json
      end
      @auth_token = response.body["auth_token"]
    end

    def infrastructure()
      Infrastructure.new(self)
    end

    def machine()
      Machine.new(self)
    end
  
    def reading()
      Readings::Reading.new(self)
    end
  end
end
