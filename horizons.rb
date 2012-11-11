require 'rubygems'
require 'bundler'
Bundler.require

class Horizons < Sinatra::Base
  def client
    @_client ||= Tengai::Client.new
  end

  get '/' do
    File.read('public/index.html')
  end
  get '/bodies/:body' do
    body = Tengai::Body.find(client, params['body'])
    body.data
  end

  run! if app_file == $0
end
