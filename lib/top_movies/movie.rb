class TopMovies::Movie
    attr_accessor :name, :year, :url, :site

    def self.all_time
      #return top movies of this year

      self.scrape_movies
    end

    def self.scrape_movies
      deals = []
      deals << self.scrape_imdb
      deals << self.scrape_rotten_tomatoes

      deals
    end

    def self.scrape_imdb
      movie = self.new
      movie.site = "IMDB"
      doc = Nokogiri::HTML(open("http://www.imdb.com/chart/top"))
      movie.name = doc.search("tr td")[1].children.children.first.text
      movie.year = doc.search("tr td")[1].children[3].children.text
      movie.url = doc.search("tr td")[1].children[1].attributes.first.last.value

      movie
    end

    def self.scrape_rotten_tomatoes
      movie = self.new
      movie.site = "Rotten Tomatoes"
      doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
      movie.name, movie.year = doc.search("tr td")[28].children.children.text.split("\n            ")[1]
      movie.url = "www.rottentomatoes.com"+doc.search("tr td")[28].children[1].attributes.first.last.value

      movie
    end
end
