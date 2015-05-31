class LibVimeo
    def get_setting
      settings = {}
      settings[:embed_url] = 'https://player.vimeo.com/video/'
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
      setting = get_setting
      tag_format = setting[:tag]
      result = tag_format % movie_url
      return result
    end

    #
    # 呼び出し用動画URLの生成
    #
    def create_embed_url(movie_url)
      setting = get_setting
      prefix = setting[:embed_url]
      youtube_movie_url_format = "%s%s"
      result = youtube_movie_url_format % [prefix, movie_url]
      return result
    end

    #
    # youtubeのURL取得
    #
    def scraping_url(attribute, url)
      result = {}
      provider_url = '//player.vimeo.com'
      re = /^(http.?:)?\/\/player.vimeo.com\/video\/(.*?)$/
      url_index = url.index(provider_url)
      if attribute == 'src' && url_index && url_index >= 0
        result[:url] = url.strip.gsub(re, '\2')
        result[:provider] = Models::PROVIDER_VIMEO
      end
      return result
    end

end
