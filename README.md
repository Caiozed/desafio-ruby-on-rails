# Ruby On Rails - BycodersTest
Project made in Ruby on Rails with the object of parsing a text file, saving it to the database and displayng the data on a webpage.

# Requirements

1. Ruby 2.0+
2. Rails 5+
3. Drocker and Docker-compose

# Running instructions
1. Create the docker container and image: ```sudo docker-compose up```
2. navigate to http://localhost:3000
3. Done!


# Running tests 
1. run ```sudo docker-compose run -e "RAILS_ENV=test" web bundle exec rake assets:precompile``` once
2. then ```sudo docker-compose run -e "RAILS_ENV=test" web bundle exec rspec``` to run the tests