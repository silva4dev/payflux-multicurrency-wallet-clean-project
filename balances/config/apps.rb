# frozen_string_literal: true

Padrino.configure_apps do
  enable :sessions
  set :session_secret, 'aad6b2ebea3d51804462cde9e37e9f0b23f582ba76ffd9f6c1d1c838c54a1159'
end

Padrino.mount('Ruby::App', :app_file => Padrino.root('app/app.rb')).to('/')
