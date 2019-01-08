require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  #binding.pry
  # puts response_hash
  filmDataArray = []
  response_hash["results"].each do |element|
   if element["name"] == character_name
     puts "Yes, he/she/it exists. One moment please..."
       element["films"].each do |film|
         film_response_string = RestClient.get(film)
         film_response_hash = JSON.parse(film_response_string)
         #film_response_hash
         filmDataArray.push({film_response_hash["title"] => film_response_hash})
       end
   end
 end
 return filmDataArray
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
  films.each.with_index {|elem, i|
    keysArr = elem.keys
    puts "#{i + 1}. #{keysArr[0]}"
  }
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

#puts get_character_movies_from_api("Darth Vader")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
