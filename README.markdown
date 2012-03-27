### Base Node.js app for Heroku

Here's a basic set of instructions on developing locally and deploying to Heroku.

### Local Development

* `$ npm install` to install all required node modules.
* `$ nodemon server.js` to boot server, visible at localhost:3000.
* `$ coffee -w -c *.coffee public/js/*.coffee` to auto-compile CoffeeScript files.

### Heroku Deployment

* `$ heroku create --stack cedar` to create your app.
* `$ git push heroku master`
* `$ heroku ps:scale web=1`
* `$ heroku config:add NODE_ENV=production`
