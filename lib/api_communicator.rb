require 'rest-client'
require 'json'
require 'pry'

def get_characters
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  #make the web request
  get_characters
  character = get_characters["results"].find {|character| character["name"].downcase==character_name}
  character["films"].map do |film|
    JSON.parse(RestClient.get(film))
  end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films = films.sort_by {|film| film["episode_id"]}
  films.each do |film|
    puts "*" * 30
    puts "Title: #{film["title"]}"
    puts "Episode: #{film["episode_id"]}"
    puts "Description: #{film["opening_crawl"][0..150]}"
    puts "Release Date #{film["release_date"]}"
    puts "Director: #{film["director"]}"
    puts "Characters:"
    film["characters"].each do |url|
      puts JSON.parse(RestClient.get(url))["name"]
    end
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end
