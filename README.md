# Whether, Sweater? README
This project is part of Mod 3 for [Turing School of Software and Design Backend](https://backend.turing.edu/module3/projects/sweater_weather/requirements) final solo project, where we were asked to build a backend api for imaginary front-end team to utilize. 
The goal of this backend team is to build API that exposes only necessary items from the API calls we make to [weather api](https://www.weatherapi.com/), [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/), and [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/). Furthermore, the backend implemented a user creation and user sign in. This app is the proxy for the front-end application and micro-services. The testing was completed utilizing Webmock, and happy path and sad path, where applicable, were implemented.      

# Built With (and Gems)
- Ruby on Rails
- Pry
- Simplecov
- Rspec-rails
- Faraday
- Capybara
- Launchy
- Webmock
- JSONAPI-serializer
- Bcrypt
- Shoulda-matchers

# Getting Started
If you want to checkout the end points using postman, please clone and/or fork this project and follow these steps:

##### API:
  - [Weather API](https://www.weatherapi.com/signup.aspx), sign up for a key 
  - [MapQuest API](https://developer.mapquest.com/user/login/sign-up), sign up for a key

##### Set up:
  - run `bundle`
  - `rails db:{create,migrate}`
  - Configure credentials (API keys obtained above)
  - Connect to `rails s`
  - Open postman, input endpoints and appropriate request
  
  *example* <br>
  
  To get the weather for a city, 
  ```json
  GET http://localhost:3000/api/v0/forecast?location=cincinatti,oh
  ```

  expected result
  ```json
  {
    "data": {
      "id": null,
      "type": "forecast",
      "attributes": {
        "current_weather": {
          "last_updated": "2023-04-07 16:30",
          "temperature": 55.0,
          etc
        },
        "daily_weather": [
          {
            "date": "2023-04-07",
            "sunrise": "07:13 AM",
            etc
          },
          {...} etc
        ],
        "hourly_weather": [
          {
            "time": "14:00",
            "temperature": 54.5,
            etc
          },
          {...} etc
        ]
      }
    }
  }
  ```

Follow [these instructions](https://backend.turing.edu/module3/projects/sweater_weather/requirements) to try more endpoint. 