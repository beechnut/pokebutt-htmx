require 'sinatra'
require 'net/http'
require 'json'

# get '/b' do
#   erb :b
# end

get '/c' do
  erb :c
end


POKEMON_RANGE = (1..151)

get '/' do
  erb :index
end

post '/load' do
  puts "PARAMS: #{params.inspect}"
  id = -1 # out of range, but not nil
  while true
    id = rand POKEMON_RANGE
    break if id != params[:current].to_i
  end
  resp = get_pokemon(id)
  @pokemon = build_pokemon(resp)
  erb :load
end

get '/some_json' do
  content_type :json
  { beatles: [{name: "George"}, {name: "Paul"}, {name: "John"}, {name: "Ringo"}] }.to_json
end

Pokemon = Struct.new(:id, :name, :butt_url)

def build_pokemon(response)
  Pokemon.new(
    response[:order],
    response[:name],
    response.dig(:sprites, :back_default)
  )
end

def get_pokemon(id)
  assert_pokemon(id)
  path = "https://pokeapi.co/api/v2/pokemon/#{id}"
  uri  = URI(path)
  resp = Net::HTTP.get(uri)
  JSON.parse(resp, symbolize_names: true).merge(url: path)
end

def poke_url(id)
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/#{id}.png"
end

private

def assert_pokemon(id)
  unless (1..151).include?(id)
    raise ArgumentError, "There are only 151 Pokemon, your ID was #{id}"
  end
end
