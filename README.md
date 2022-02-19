# Weapi

Yet another [MetaWeather](https://www.metaweather.com/) api console line to demonstrate my knowledge in ruby.

## Usage

I've used [Thor gem](http://whatisthor.com/) to pack an cli with the following commands:
```shell
weapi help [COMMAND]            # Describe available commands or one specific command
weapi raining-tomorrow-at CITY  # Check if tomorrow is raining at CITY
weapi weather-on DATE CITY      # Get weather for a CITY on given DATE (2020-01-01 format)
weapi weather-tomorrow-at CITY  # Get tomorrow's weather for a CITY
```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).