require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_find_neos_by_date
    results = NearEarthObjects.find_neos_by_date('2019-03-30')
    assert_equal '(2019 GD4)', results[:astroid_list][0][:name]
  end

  def test_conn_contains_start_data_and_api_key
    conn = NearEarthObjects.conn('2019-03-30')
    assert_equal "2019-03-30", conn.params["start_date"]
    assert_equal "y8Jidgd0tvnHAkfhdL9QIgVudZulJpHnZdHbpvCe", conn.params["api_key"]
  end

  def test_asteroids_data_parsed_response
    asteroids_data = NearEarthObjects.asteroids_data('2019-03-30')
    assert_instance_of Array, asteroids_data
    assert_equal 12, asteroids_data.count
    assert_equal "(2019 GN1)", asteroids_data[1][:name]
  end

  def test_largest_asteroid_diameter
    largest_astroid_diameter = NearEarthObjects.largest_astroid_diameter('2019-03-30')
    assert_equal 10233, largest_astroid_diameter
  end

  def test_total_number_of_asteroids
    total_number_of_astroids = NearEarthObjects.total_number_of_astroids('2019-03-30')
    assert_equal 12, total_number_of_astroids
  end

  def test_formatted_asteroid_data
    formatted_asteroid_data = NearEarthObjects.formatted_asteroid_data('2019-03-30')
    assert_equal "(2019 GD4)", formatted_asteroid_data[0][:name]
    assert_equal "61 ft", formatted_asteroid_data[0][:diameter]
    assert_equal "911947 miles", formatted_asteroid_data[0][:miss_distance]
  end
end
