# QuickCommand WeatherService

## About this Project
The QuickCommand WeatherService is the microservice application that connects to two external APIs: Open Weather API and Mapquest API services. Each service is necessary for creating the daily forecast as well as finding the coordinates for a given location and calculating distance in miles to the site of an incident. These external APIs are combined within QuickCommand's WeatherService which is built on the lightweight framework Sinatra and endpoints are then created to connect the QuickCommand engine with this mircroservice to feed necessary data to the client-side.    

## Table of Contents

  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Other Repos](#other-repos)
  - [Running the tests](#running-the-tests)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Authors](#authors)

## Getting Started

To get the web application running, please follow these directions to set up your local machine's testing and development environments. Please follow the section for deployment to see how to deploy this application on Heroku.

  ### Prerequisites
  To run this application you will need Ruby 2.5.3 and Sinatra 2.1.0, 1.4.8

  ### Installation
    1. Clone this repo using the following command:
      `$ git clone git@github.com:Quick-Command/weather_service.git/`

    2. Run bundle install:
      `$ bundle install`

    3. Add Environment Variables
     - First, add the `Figaro` gem to the `development/test` section of the Gemfile and `$ bundle install`: `gem "figaro"`
     - run the command `$ bundle exec figaro install`
     - Add the following environment variables to your `config/application.yml` for access to the external apis:
        - To have access to these external apis, please follow the directions from the respective websites to set up personal API keys:
            - Open Weather API: https://openweathermap.org/api
            - Mapquest API: https://developer.mapquest.com/

        - The API keys will need to be concealed in the following environment variables:
          - MAPQUEST_KEY: <YOUR_API_KEY>
          - WEATHER_KEY: <YOUR_API_KEY>  

     **IMPORTANT**
     It is imperative that the application.yml file is added to .gitignore so that the personal API keys are not exposed remotely on Github.

## Other Repos

- To explore the full application capabilities, please visit the front end application which hooks into the backend engine and its endpoints:
  - [Repo](https://github.com/Quick-Command/QuickCommand) | [Heroku](https://quick-command.herokuapp.com/)

- For more information on the QuickCommand backend engine, please visit the following links:
  - [Repo](https://github.com/Quick-Command/qc-engine) | [Heroku](https://qc-engine.herokuapp.com/)


## Endpoints
  ### QuickCommand API Contract Weather Microservice  

| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| GET | /api/v1/forecast_data?location={location} | Get up to five day daily forecast for a specific location | [json](#get-forecast_data) |
| GET | /api/v1/distance?origin={origin}&destination={destination} | Get travel distance from origin to site of incident | [json](#get-distance) |


## Types of Forecast (an forecast can be one type)
- Daily Weather
​- Hourly Weather
- Current Weather
​
## JSON Responses
​
## Forecast
`GET /api/v1/forecast_data?location=Denver,CO`
  ```json
  {
    "data": {
    "id": "null",
    "type": "forecast",
    "attributes": {
        "daily_weather": [
            {
              "date": "2021-05-17",
              "sunrise": "2021-05-17 05:31:21 -0500",
              "sunset": "2021-05-17 19:14:57 -0500",
              "min_temp": "42.7",
              "max_temp": "74.9",
              "humidity": "11.0",
              "wind_speed": "12.03",
              "wind_deg": "87",
              "wind_gust": "17.69",
              "conditions": "overcast clouds",
              "precipitation": "0"      
             }
         ]
     }
  }
}
  ```

## Distance
`GET /api/v1/distance?origin=Denver,CO&destination=Seattle,WA`
  ```json
  {
    "data": {
    "id": "null",
    "type": "distance",
    "attributes": {
                    "origin": "Denver,CO",
                      "destination": "Seattle,WA",
                      "distance_in_miles": "1333.6141",
                      "drive_time": "18 hours, 24 minutes away."
                  }
            }
      }
```
## Built With
- Ruby
- Sinatra
- RSpec
- Shotgun

## Versioning
- Ruby 2.5.3
- Sinatra 2.1.0, 1.4.8

## Authors
- **Alexa Morales Smyth**
| [GitHub](https://github.com/amsmyth1) |
  [LinkedIn](https://www.linkedin.com/in/moralesalexa/)
- **Cameron Mackintosh**
| [GitHub](https://github.com/cbmackintosh) |
  [LinkedIn](https://www.linkedin.com/in/cameron-mackintosh-1341b173/)
- **Chuck Morris**
| [GitHub](https://github.com/percworld) |
  [LinkedIn](https://www.linkedin.com/in/chuck-morris-56819918/)
- **Jeff Shepherd**
|  [GitHub](https://github.com/JeffShepherd) |
  [LinkedIn](https://www.linkedin.com/in/jefflshepherd/)
- **Jeremiah Michlitsch**
|  [GitHub](https://github.com/jmichlitsch) |
  [LinkedIn](https://www.linkedin.com/in/jeremiah-michlitsch-49048a206/)
- **Katy La Tour**
| [GitHub](https://github.com/klatour324) |
  [LinkedIn](https://www.linkedin.com/in/klatour324/)
