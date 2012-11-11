class Horizons < Sinatra::Base
  get '/bodies/:body' do
    client = Tengai::Client.new
    body = Tengai::Body.find(client, params['body'])
    body.data
  end

  run! if app_file == $0
end
