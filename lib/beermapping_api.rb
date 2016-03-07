class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  def self.place_in(id, city)
    city = city.downcase
    places_in(city).select{ |p| p.id==id }.first
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    "9ffdd0fd979d4341af0b9e1c2999d011"
    #raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    #ENV['APIKEY']
  end
end