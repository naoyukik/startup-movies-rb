# coding: utf-8

require 'open-uri'
require 'nokogiri'
require 'sinatra/base'
require 'sinatra/reloader'

class LibScrape

    #
    # スクレイピングを行う
    #
    def scraping_site_data(url=nil)
      charset = nil
      html = open(url, "r:binary") do |site|
        charset = site.charset
        site.read
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)
      movies = scraping_iframe(doc)
      return movies
    end

    #
    # iframeをscraping
    #
    def scraping_iframe(doc)
      lib_platform = [LibYoutube.new, LibVimeo.new]
      movies = []
      for lp in lib_platform do
        doc.search("iframe").each do |iframe_value|
          iframe_value.attributes.each do |attr_key, attr_value|
            scraping_list = lp.scraping_url(attr_key, attr_value.value)
            if scraping_list.length > 0
              movies << scraping_list
            end
          end
        end
      end
      return movies
    end

end

# scraping_site_data('http://tales-ch.jp/movie_archive.php')
