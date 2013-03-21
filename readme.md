<img src='http://aralbalkan.com/images/tally-hello-world.png'>

Tally: Hello badge example (part 1 of 4)
===

This is a very simple example for the [Tally template engine](http://tally.jit.su) ([Fork Tally on GitHub](https://github.com/aral/tally)).

It demonstrates how to set up Tally for use with [Express 3](http://expressjs.com) and how to use the ```data-tally-text``` and ```data-tally-attribute``` attributes to set the value of the text and attribute of a DOM element.

Usage
---

1. Clone the repository.
2. Run server.coffee (I use ```nodemon server.coffee``` while developing. Or you can just run ```coffee server.coffee```). Once the server is running, go to ```http://localhost:3000``` to see the example and ```http://localhost:3000/hello-badge.html``` to see the template source.
3. Read the notes below and take a peek at the source code.

How it works
---

Templates in Tally are pure HTML 5. Tally uses ```data-``` attributes to populate templates either on the server or on the client (or both).

In this simple example, we want to create a simple name badge that links back to the user’s home page.

The name of the user and the link to her homepage are variables (perhaps from a database, although in this example we will hard code them).

The template
---

Let’s start by creating a template called ```hello-badge.html``` in the ```/views``` folder. It will contain a paragraph tag to hold the title of the label (’Hello, my name is’) and a nested span into which the name of the user will be added when the template is compiled.

```<p>Hello, my name is <span data-tally-text='name'>Inigo Montoya</span></p>```

The attribute ```data-tally-text``` tells Tally to replace the text of the ```span``` tag with the property ```name``` that’s in the data provided to the template.

Since Tally templates are pure HTML, you can design in the browser with the template even before the server is ready (and work on both can continue in parallel). Unlike Moustache‐style template engines like Handlebars, etc., your template is What You See Is What You Get.

Next, we wrap the paragraph tag in an anchor tag for the link. This time, instead of the text of the anchor tag, we want to change its ```href``` attribute, so we use the ```data-tally-attribute``` attribute instead.

```<a data-tally-attribute='href homepage'><p>Hello, my name is <span data-tally-text='name'>Inigo Montoya</span></p></a>```

To specify multiple attributes, just separate them with a semicolon.

The server
---

The server couldn’t be simpler. Here’s all the code:

```javascript
express = require 'express'
tally = require 'tally'

app = express()
app.engine 'html', tally.__express
app.set 'view engine', 'html'
app.use express.static('views')

data = {
		name: 'Aral'
	,	homepage: 'http://aralbalkan.com'
}

app.get '/', (request, response) ->
	response.render 'hello-badge', data

app.listen 3000
```

We set up Express and create a static data object with ```name``` and ```homepage``` properties. When the default route is called on the server with a GET request, we render the hello-world.html template, passing it the data object.

That’s it!

Unlike other unobtrusive frameworks like Plates and Notemplate, Tally has no mapping code to write. It just works.

This is just a very simple example. [Check out the Tally web site](http://tally.jit.su) for more complicated ones.