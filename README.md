# Inventory
This is an inventory web app that uses subdomains to silo different store locations data from each other.
The different stores are available in this [google doc](https://docs.google.com/spreadsheets/d/1r1XIqd82B8-2zVBBeXE1AkPoYmedLGqhHkGoTrqId7Y/edit#gid=299900256). The store names are lower-cased and hyphenated and unsafe url characters removed; "Silver Grill & Tap" becomes silver-grill-tap for example.
Currently there are two actions available for each location: See a list of recipes (menu items) and adjust the ingredient inventory for a location. 

## Getting Started

### With Docker

1. Copy the .env.sample file into a file named .env
2. run `docker-compose up db`, add `-d` if you want to run it in the background
3. run `docker-compose build web` in a new terminal (or same if you are running db in background)
4. run `docker-compose run web bash`.
5. To set up the database run `rails db:migrate`. Let that finish.
6. To populate the db run `bundle exec rake backfill_initial_data:run` and let that finish.
7. Type `exit` to close the bash shell.
8. Run `docker-compose up web` to start the server.

### Running locally (on your machine)

*This assumes you have [Bundler](https://bundler.io/guides/getting_started.html) installed*
*This has only been tested on a macOS in practice*
*Yarn should install packages for Linux, Mac and Windows but for the rest there may be some differences in running commands or other things* 

1. Run `bundle install` to install the Rails dependencies
2. To create the database run `rails db:create`
3. Copy .env.sample into a file name .env.development. Change database_name to be the development database that the previous command created, and "db" to "localhost"
4. To set up the database run `rails db:migrate`. Let that finish.
5. To populate the db run `bundle exec rake backfill_initial_data:run` and let that finish.
6. Run `yarn install` to build your javascript dependencies. 
7. Run `bin/dev` to start the server.

## Navigate in the app

Open a browser to navigate to sweet-cafe.localhost:3000 (or any other cafe name). You should see a landing page with 2 buttons: View Menu and Register Delivery.
Currently the View Menu just shows all menu items for that location, but ideally it would grey out menu items where there aren't enough ingredients to fulfill an order. The sell button isn't functional at the moment, but the thought it that once it is, should only be blickable for a non-greyed out item and when an item is sold, the ingredients for that gets deducted from the inventory and register as an inventory change.
The Register Delivery shows all the ingredients for a locations menu items and their cost, unit of meassurement and current stock. It is order alphabetically so that it's easy to find items and add inventory when you get a delivery. 
Currently this view also offers the ability to deduct inventory to record waste for example as you can input negative numbers, but I would like for the app to have a different page for that where the input fields are prepopulated with the current inventory. Not just for visual difference, but currently when you add a delivery it gets processed with the change type of 'delivery'. This page could become multi-purpose with the addition of an inventory change type button/input, and send that along with the inventory numbers.

**Gotcha**: There is an issue with reloading a page that is not the root. You will only see the json output if you reload, type in url directly or change location (subdomain) on /inventory/delivery or /recipes. Go back to root subdomain.localhost:3000 and use the buttons to navigate. 

## Navigate in the code

This is a one repo Rails 7 application with a react front end. The Rails portion is mainly as a backend server and all the views are handled in app/javascript/. The front end has a react router to handle url and view routing (app/javascript/routes) and the rails backend has the business logic in app/models and app/controllers. The rails routing is located in config/routes.rb

Some good commands and tools:
- `rails c`: open up an interactive ruby console within the app context. Can check relationships such as `Location.first.employees` or `Employee.first.locations`
- For the ruby portion you can add `byebug` anywhere in the code and it'll add a breakpoint there where you can inspect variables, and step through line by line. This does not work with foreman, which is what is used by the `bin/dev` command, so if you are working through something start the server with `rails s`.


## What's next? 

- [ ] Add tests! This code has **0% coverage** so far. Once tests have been added, set up a build process perhaps?
- [ ] it has a linter for ruby; rubocop. Add one for css + js?
- [ ] Filter/grey out recipes that don't have enough inventory to be fulfilled.
- [ ] Make that sell button do something.
- [ ] Add a page for recording inventory loss, alternatively update the delivery page to handle both cases better. 
- [ ] Allow employees to log in (but only to their locations) and record what user does what in the app.
- [ ] Location manager area - run reports, add staff and recipes to their location etc.
- [ ] Company Admin area - add locations, create new staff accounts, create new recipes and ingredients.
- [ ] Allow delivery updates to happen through a file upload or photo of a receipt.
- [ ] and more

