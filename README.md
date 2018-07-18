# Address Validator Coding Challenge

Having accurate addresses is important for Vote.org. In this challenge you will be given a 
very basic rails app that consists of a form with a field for 
- street address 
- city
- state 
- zip

The goal is to have the form validate the input to see if it forms a valid address
and if so, save the address components in the respective columns.

While not all addresses will have a value for every column it is important not to lose any
address information provided. For example if an address post direction value or unit value
is provided, those must be saved. Additionally any addresses that are not real addresses 
should not be saved. As a rule, all addresses should have
 - house number
 - street name 
 - city 
 - state (saved as 2 letter state abbreviation)
 - 5 digit zip code (only numbers) 

It is your job to update the Address model and controller so that all validated 
addresses are saved to the database and no invalid addresses are saved. The Address model
also has a `#to_s` method that needs to be filled in so that it returns the address as 
a string. 
 
While front end validation and feedback to the user is expected, you should not rely only on 
front end validations. Additionally a suggested layout has been included in a file labeled 
"wireframe.png". Feel free to use this mock or come up with a different design of the frontend. 

A few test cases have been provided to help get you started. You are encouraged to write more
tests as you go, but DO NOT delete any of the existing tests. Also, you may not change the
schema.

## Prerequisites

You'll need the following installed on your system:
1. ruby
2. rails
3. sqlite3

Instructions can be found here: http://guides.rubyonrails.org/getting_started.html#installing-rails

## Getting started

To run the project as is:
1. `bundle install`
2. `rake db:create`
3. `rake db:migrate`
4. `rails s`

To run the tests:
1. `rails generate rspec:install`
  (When prompted to overwrite spec/spec_helper.rb enter `n`)
2. `rspec` (or `bundle exec rspec`)

If everything is set up properly you should see `10 examples, 7 failures` to start. 
 
Here are some useful resources for Ruby On Rails:
- https://www.tutorialspoint.com/ruby-on-rails/rails-controllers.htm
- http://guides.rubyonrails.org/active_model_basics.html
- http://guides.rubyonrails.org/action_controller_overview.html
- http://guides.railsgirls.com/app
- https://www.railstutorial.org/book/toy_app
- https://relishapp.com/rspec/rspec-rails/v/3-7/docs (docs for rspec testing)

Information on Address standards / validations:
- https://pe.usps.com/text/pub28/28c1_001.htm

Here are some services that can be used for address validation:
- https://developers.google.com/maps/documentation/geocoding/intro
- https://wiki.openstreetmap.org/wiki/Nominatim
- https://developers.arcgis.com/rest/geocode/api-reference/overview-world-geocoding-service.htm
If you need an api key or are interested in using another service please let us know.

Your finished project should:
- validate addresses
- not save any invalid addresses
- be styled on the front end
- validate fields on the front end
- display feedback to the user
- be well-tested

When submitting the project please answer the following questions:
 1. What gems if any did you choose to use and why?
 I made use of 3 different gems. I used the Lob gem library that focuses primarily on validating addresses. If I had more time I probably would have written my own against the UPS Api but this gem seemed well-maintained. I also used jquery & jquery-validation to implement the client-side validating for the input fields.
 
 2. Were there any specific challenges or struggles you faced along the way?
 Other than time, not really. I cut a few corners that I would have ideally spent more time on for a more robust and elegant solution but it successfully did what it needed to.
 
 3. Is there anything you'd want to improve or optimize if you had more time?
 Oh yeah, I would incoporate bootstrap as a gem in order to change less files and have the dependencies needed loaded like the other libraries. Implement the validateAddress function in a more abstract way to decouple the validating functionality with the library used that way if we want to use a different library it can easily be changed out. A class for the string constants or "magic strings" I used. Also some more testing around the validateAddress function too to ensure its working fully as expected.
 
 4. If you were to take this project to production, what would be on your list of things to do?
 More unit tests definitely, adding configurations to the respective production files, adding logging to have insight into any errors that occur. Encrypting any sensitive data and ensuring that it's fault tolerant. So making sure if the server goes down, the web server is started back up immediately along with any load balancing included. Also have to ensure that the database can be accessed and is set to scale as well. Ideally have continuous deployment set up with something like Bamboo to automatically push up new versions and fixes once they're ready.







