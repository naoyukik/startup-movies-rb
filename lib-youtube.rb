class LibYoutube
    def get_setting
      settings = {}
      settings[:embed_url] = 'https://www.youtube.com/embed/'
      settings[:tag] = '<iframe width="560" height="315" src="%s" frameborder="0" allowfullscreen></iframe>'
      return settings
    end

    #
    # embedタグの生成
    # 引数 movie_dataには、site_dataテーブルから取得したデータを渡す
    #
    def create_embed_data(movie_data)
      movie_url = create_embed_url(movie_data['movie_url'])
      result = create_embed_tag(movie_url)
      return result
    end

    #
    # 呼び出し用動画タグの生成
    #
    def create_embed_tag(movie_url)
      tag_format = '<iframe width="560" height="315" src="%s" frameborder="0" allowfullscreen></iframe>'
      result = tag_format % movie_url
      return result
    end

    #
    # 呼び出し用動画URLの生成
    #
    def create_embed_url(movie_url)
      prefix = 'http://www.youtube.com/embed/'
      youtube_movie_url_format = "%s%s"
      result = youtube_movie_url_format % [prefix, movie_url]
      return result
    end

    #
    # youtubeのURL取得
    #
    def scraping_url(attribute, url)
      result = {}
      provider_url = '//www.youtube.com'
      re = /^(http.?:\/\/|\/\/)www.youtube.com\/embed\/(.*?)$/
      url_index = url.index(provider_url)
      if attribute == 'src' && url_index && url_index >= 0
        result[:url] = url.strip.gsub(re, '\2').split('?')[0]
        result[:provider] = Models::PROVIDER_YOUTUBE
      end
      return result
    end

end
