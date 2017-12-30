#CLI Controller
class TopMovies::CLI

  def call
    list_movies
    menu
  end

  def list_movies
    puts <<-DOC
                    Top movies of all time:
            IMDB                            Rotten Tomatoes
    1. The Shawshank Redemption          2. The Wizard of Oz

  DOC

      @movies = TopMovies::Movie.all_time
      @movies.each.with_index(1) do |movie, i|
        puts "#{i}. #{movie.site} - #{movie.name} - #{movie.year}"
      end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the movie you would like to learn more about, type list to list the movies again, or type exit:"
      input = gets.strip

      if input.to_i > 0 && input.to_i < 3
        the_movie =  @movies[input.to_i-1]
        puts  "#{the_movie.site} - #{the_movie.name} - #{the_movie.year}"
      elsif input == "list"
        list_movies
      elsif input == "exit"
        goodbye
      else
        puts "I don't understand. Read the menu and try again."
      end
    end
  end

  def goodbye
    puts "See you the next time you are curious!"
  end

end
