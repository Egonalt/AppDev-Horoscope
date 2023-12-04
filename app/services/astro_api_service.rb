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
    request.body = {
      day: day,
      month: month,
      year: year,
      hour: hour,
      min: min,
      name: name,
      lat: lat,
      lon: lon,
      tzone: tzone
    }.to_json

    response = http.request(request)
    Rails.logger.info "API Response: #{response.body}"
    JSON.parse(response.read_body)
  rescue StandardError => e
    Rails.logger.error "API Error: #{e.message}"
    { error: e.message }
  end
end
