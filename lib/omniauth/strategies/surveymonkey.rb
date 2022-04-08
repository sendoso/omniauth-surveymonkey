require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Surveymonkey < OmniAuth::Strategies::OAuth2
      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'
      option :name, 'surveymonkey'

      option :client_options, {
        site: 'https://api.surveymonkey.net',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }

      option :authorize_options, [:api_key, :client_id]

      uid { raw_info['id'] }

      info do
        {
          'username' => raw_info['username'],
          'name' => [raw_info['first_name'], raw_info['last_name']].join(' '),
          'email' => raw_info['email']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v3/users/me').parsed
      end

      def authorize_params
        super.tap do |params|
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = options[:client_id]
          params[:api_key] = options[:api_key]
        end
      end

      def build_access_token
        verifier = request.params['code']
        token = client.auth_code.get_token(verifier, token_params)
      end

      def callback_phase
        options[:client_options][:token_url] = "/oauth/token?api_key=#{options[:api_key]}"
        self.access_token = build_access_token
        self.env['omniauth.auth'] = auth_hash
        call_app!

        rescue ::OAuth2::Error, CallbackError => e
          fail!(:invalid_credentials, e)
        rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
          fail!(:timeout, e)
        rescue ::SocketError => e
          fail!(:failed_to_connect, e)
      end

      def token_params
        super.tap do |params|
          params[:grant_type] ||= DEFAULT_GRANT
          params[:client_id] = options[:client_id]
          params[:client_secret] = options[:client_secret]
          params[:redirect_uri] = callback_url
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def full_host
        case OmniAuth.config.full_host
        when String
          OmniAuth.config.full_host
        when Proc
          OmniAuth.config.full_host.call(env)
        else
          if request.scheme && request.url.match(URI::ABS_URI)
            uri = URI.parse(request.url.gsub(/\?.*$/, ''))
            uri.path = ''
            uri.scheme = 'https' if ssl?
            uri.to_s
          end
        end
      end

      def script_name
        @env['SCRIPT_NAME'] || ''
      end

      def callback_path
        @callback_path ||= begin
          path = options[:callback_path] if options[:callback_path].is_a?(String)
          path ||= current_path if options[:callback_path].respond_to?(:call) && options[:callback_path].call(env)
          path ||= custom_path(:request_path)
          path ||= "#{path_prefix}/#{name}/callback"
          path
        end
      end
    end
  end
end
