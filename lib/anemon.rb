module Anemon
  class Scrapper
    require 'anemone'
    require 'nokogiri'
    require 'open-uri'

    def scrap(url)

      filename = url.gsub("http://", "").split(".").join("_").strip + ".txt"

      # only scrap pages you havent scrapped yet
      if File.file?(filename)
        puts "This page has already been scrapped"
      else
        puts "scrapping #{url} for data..."
        data = []
        crawl(url).each do |urli|
          html_data = open(urli).read
          nokogiri_object = Nokogiri::HTML(html_data)
          elements = nokogiri_object.xpath("//p")

          elements.each do |element|
            data = element.text
          end
        end
        write_to_file(url, data)
        store_visited_link(url)
        # in ruby the last statement in a method is always the returned value
        # of the particular method
        {:url => url, :content => data }
      end
    end

    def compare(filename ,file_name)
      scrapdata = File.readlines(filename)
      uploaded_data = File.readlines(file_name)

      unless (scrapdata && uploaded_data).empty? 
        Puts "Plagiarism detected"
      else
         scrap(url)
      end
    end

    private

    def crawl(url)
      puts "crawling the web..."
      urls = []
      Anemone.crawl(url) do |anemone|
        anemone.on_every_page do |page|
          links = page.url
          urls.push(links)
        end
      end
      # returns urls as an array
      urls
    end

    def write_to_file(url, data)
      filename = url.gsub("http://", "").split(".").join("_").strip + ".txt"
      #File.file?(filename) will only return true for files
      #File.exists?(filename) will only return true for directories  watch out
      if File.file?(filename)
        File.open(filename,"w"){ |file| file.write(data)}
      else
        scrapped_file  = File.new(filename,"w+")
        File.open(filename,"w"){ |file| file.write(data)}
        scrapped_file.close
      end
      @scrap_file = File.readlines(filename)
    end

    def store_visited_link(url)
      if File.file?("visited_links.txt")
        File.open("visited_links.txt","a"){|file| file.puts(url) }
      else
        @visited = File.new("visited_links.txt","w")
        File.open("visited_links.txt","w"){ |file| file.write(url)}
        @visited.close
      end
    end
  end
end
#plag = Anemon::Scrapper.new
#plag.scrap('http://google.com')
