# frozen_string_literal: true

module Ruby
  class App < Padrino::Application
    enable :sessions

    set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    set :reload, true            # Reload application files (default in development)
  end
end
