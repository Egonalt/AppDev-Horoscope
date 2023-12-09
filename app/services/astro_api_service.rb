require 'uri'
require 'net/http'
require 'json'

class AstroApiService
  def self.fetch_astro_details(day, month, year, hour, min, name, lat, lon, tzone)
    url = URI("https://vedicrishi-horoscope-matching-v1.p.rapidapi.com/numero_table/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["X-RapidAPI-Key"] = ENV['RAPIDAPI_KEY'] 
    request["X-RapidAPI-Host"] = 'vedicrishi-horoscope-matching-v1.p.rapidapi.com'

    request_body = {
      day: day,
      month: month,
      year: year,
      hour: hour,
      min: min,
      name: name,
      lat: lat,
      lon: lon,
      tzone: tzone
    }
    request.body = request_body.to_json

    response = http.request(request)
    JSON.parse(response.read_body)
  rescue StandardError => e
    # Handle any exceptions
    { error: e.message }
  end
end
