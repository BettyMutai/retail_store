require 'sinatra'
require 'sinatra/reloader'
require './lib/class.rb'
also_reload('lib/**/*.rb')

get('/') do
	erb(:index)
end

post ('/') do
	sales=Sales.new()
	@sku=params['sku']
	myhash=sales.getFinalResults(@sku)
	@totalsale=myhash.fetch("firsthash").fetch("total_KSH")
	@topstore=myhash.fetch("secondhash").fetch("topstore")
	@highestsale=myhash.fetch("highestsale")
	erb(:index)
end
