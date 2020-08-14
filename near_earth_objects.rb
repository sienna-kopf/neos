require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.conn(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
  end

  def self.asteroids_data(date)
    asteroids_data = self.conn(date).get('/neo/rest/v1/feed')
    JSON.parse(asteroids_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end

  def self.largest_astroid_diameter(date)
    asteroids_data(date).map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def self.total_number_of_astroids(date)
    asteroids_data(date).count
  end


  def self.formatted_asteroid_data(date)
    asteroids_data(date).map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def self.find_neos_by_date(date)
    {
      astroid_list: formatted_asteroid_data(date),
      biggest_astroid: largest_astroid_diameter(date),
      total_number_of_astroids: total_number_of_astroids(date)
    }
  end
end
