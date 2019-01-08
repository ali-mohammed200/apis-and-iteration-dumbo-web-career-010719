require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  #'http://www.swapi.co/api/people/?page='
  counter = 1
  response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{counter}")
  response_hash = JSON.parse(response_string)
  filmDataArray = []
while (response_hash["next"] != nil)
    response_string = RestClient.get("http://www.swapi.co/api/people/?page=#{counter}")
    response_hash = JSON.parse(response_string)
    response_hash["results"].each do |element|
     if element["name"] == character_name
       puts "Yes, he/she/it exists. One moment please..."
         element["films"].each do |film|
           puts film
           film_response_string = RestClient.get(film)
           film_response_hash = JSON.parse(film_response_string)
           filmDataArray.push({film_response_hash["title"] => film_response_hash})
         end
         return filmDataArray
     end
   end
   counter += 1
  end

 return "Doesn't Exist"
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

puts get_character_movies_from_api("HSolo")
puts get_character_movies_from_api("Tion Medon")
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
