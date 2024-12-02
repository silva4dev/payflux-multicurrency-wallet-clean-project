# frozen_string_literal: true

module Ruby
  class App < Padrino::Application
    enable :sessions

    set :raise_errors, true
    set :dump_errors, true
    set :show_exceptions, true
    set :logging, true
    set :reload, true
  end
end
