require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  characters_data = JSON.parse(response_string)

  films_titles = []

  character = characters_data["results"].find do |character|
      character["name"] == character_name
    end
  

  
  character["films"].each do |film|
      movie_string = RestClient.get("#{film}")
      movie_data = JSON.parse(movie_string)
      films_titles << movie_data["title"]
    end
  films_titles
end

def print_movies(films_titles)
    films_titles.each do |title|
      puts title
    end
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
