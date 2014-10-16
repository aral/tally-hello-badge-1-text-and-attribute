express = require 'express'
set = require 'indie-set'

app = express()
app.engine 'html', set.__express
app.set 'view engine', 'html'
app.use express.static('views')

data = {
		name: 'Aral'
	,	homepage: 'http://aralbalkan.com'
}

app.get '/', (request, response) ->
	response.render 'hello-badge', data

app.listen 3000

console.log '\nServer running. Go to http://localhost:3000 to see the example and http://localhost:3000/hello-badge.html to see the template.\n'