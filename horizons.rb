require 'rubygems'
require 'bundler'
require 'json'
require 'date'

Bundler.require

class EphemerisTablePresenter < SimpleDelegator
  def to_hash
    map(&:to_hash)
  end
end

class EphemerisPresenter < SimpleDelegator
  def ephemeris_table
    EphemerisTablePresenter.new(super)
  end

  def to_hash
    super.merge(ephemeris_table: ephemeris_table.to_hash)
  end
end

class Horizons < Sinatra::Base
  configure do
    Tengai.debug = true
  end

  def client
    @_client ||= Tengai::Client.new
  end

  get '/' do
    File.read('public/index.html')
  end

  get '/bodies/:body' do
    body = Tengai::Body.find(client, params['body'])
    content_type :text
    body.data
  end

  get '/bodies/:body/ephemeris' do
    start_time = DateTime.parse(params['start_time']) rescue Time.now
    stop_time = DateTime.parse(params['stop_time']) rescue Time.now + 60 * 24 * 7
    body = Tengai::Body.find(client, params['body'])
    ephemeris = EphemerisPresenter.new(
      Tengai::Ephemeris.fetch(
        client, body, start_time: start_time, stop_time: stop_time, interval: params['interval']))
    deliver(ephemeris)
  end

  private
  def deliver(data)
    content_type :json
    JSON.dump data.to_hash
  end

  run! if app_file == $0
end
