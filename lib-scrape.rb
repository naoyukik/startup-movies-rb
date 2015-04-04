# coding: utf-8

require 'open-uri'
require 'nokogiri'
require 'sinatra/base'
require 'sinatra/reloader'

class LibScrape < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  class << self

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
      lib_youtube = LibYoutube.new
      movies = []
      doc.search("iframe").each do |iframe_value|
        iframe_value.attributes.each do |attr_key, attr_value|
          scraping_list = lib_youtube.scraping_url(attr_key, attr_value.value)
          if scraping_list.length > 0
            movies << scraping_list
          end
        end
      end
      return movies
    end


    # #
    # # 呼び出し用動画URLの生成
    # #
    # def create_embed_url(movie_url)
    #   movie_url = 'xohXWgCpsD0s'
    #   prefix = 'http://www.youtube.com/embed/'
    #   suffix = ''
    #   youtube_movie_url_format = "%s%s"
    #   result = youtube_movie_url_format % ([prefix, movie_url])
    #   return result
    # end

  end

end

# scraping_site_data('http://tales-ch.jp/movie_archive.php')
