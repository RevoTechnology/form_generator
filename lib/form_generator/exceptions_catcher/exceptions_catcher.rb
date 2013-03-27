module FormGenerator
  class ExceptionsCatcher
    def initialize(app)
      @app = app
    end

    def call(env)
      # @timer = {:start => Time.now}
      @status, @headers, @response = @app.call(env)
      # @timer[:stop] = Time.now

      # stats_log_maker env, @status, @headers, @timer

      [@status, @headers, @response]
    rescue Exception => error
      # exception_log_maker error, env
      raise error
    end

    ################
    ## Log makers ##
    ################
    def exception_log_maker error, environment
      {
        :exeption => exception_block_maker(error),
        :environment => env_block_maker(environment)
      }
    end

    def stats_log_maker environment, status, headers, timer
      {
        :environment => env_block_maker(environment),
        :stats => loading_stats_block_maker(status, headers, timer)
      }
    end

    ##################
    ## Block makers ##
    ##################
    def exception_block_maker error
      {
        :rised_at => Time.now,
        :message => error.message,
        :backtrace => error.backtrace,
        :blamed_file => error.blamed_files,
      }
    end

    def env_block_maker environment
      {
        :USER_AGENT => environment['HTTP_USER_AGENT'],
        :REQUEST_URI => environment['REQUEST_URI'],
        :GATEWAY_INTERFACE => environment['GATEWAY_INTERFACE'],
        :HTTP_ACCEPT => environment['HTTP_ACCEPT'],
        :HTTP_ACCEPT_ENCODING => environment['HTTP_ACCEPT_ENCODING'],
        :HTTP_ACCEPT_LANGUAGE => environment['HTTP_ACCEPT_LANGUAGE'],
        :HTTP_CACHE_CONTROL => environment['HTTP_CACHE_CONTROL'],
        :HTTP_PRAGMA => environment['HTTP_PRAGMA'],
        :REMOTE_ADDR => environment['REMOTE_ADDR'],
        :REMOTE_HOST => environment['REMOTE_HOST'],
        :SERVER_NAME => environment['SERVER_NAME'],
        :SERVER_PROTOCOL => environment['SERVER_PROTOCOL'],
        :PATH => environment["action_dispatch.request.parameters"]
      }
    end

    def loading_stats_block_maker status, headers, timer
      {
        :status => status,
        :headers => headers,
        :exec_time => timer[:stop] - timer[:start],
        :start_time => timer[:start]
      }
    end
  end
end