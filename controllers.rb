# coding: utf-8

#
# サイトindex
# 登録フォーム、ページングくらいの機能しか実装されない
#
get '/index' do
  @max_item_count = SiteData.count
  erb :index
end

#
# [API]URL登録
#
post '/api/create', provides: :json do
  create_result = []
  movie_data = nil
  params = JSON.parse request.body.read
  url_str = params['params']['url']
  movie_data = LibScrape.scraping_site_data(url_str)
  movie_data.each do |movie_datum|
    begin
      obj = SiteData.create(
        :site_name => 'title',
        :provider => movie_datum[:provider],
        :movie_url => movie_datum[:url]
      )
      create_result << obj
      rescue ActiveRecord::RecordNotUnique => e
        create_result << 'RecordNotUnique'
    end
  end
  create_result.to_json
end

#
# [API]SiteData取得
#
get '/api/site' do
  tag_result = []
  page_num = 1
  # 登録site取得
  if defined?(params[:page]) && params[:page].to_i > 0
    page_num = params[:page].to_i
  end
  SiteData.paginate(:page => page_num, :per_page => 1).each do |site_data|
    object = load_provider(site_data['provider'])
    tag_result << object.create_embed_data(site_data)
  end
  tag_result.to_json

end

#
# [API]SiteDataの件数取得
#
get '/api/count_data' do
  tag_result = []
  tag_result << SiteData.count
  tag_result.to_json
end
