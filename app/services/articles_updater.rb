class ArticlesUpdater

  def initialize(source_url, api_key)
    @source_url = source_url
    @api_key = api_key
  end

  def execute
    begin
      response = HTTP.headers('x-api-key' => @api_key).get(@source_url)
      result = response.parse
      titles = Article.limit(50).pluck(:title)

      if result['status'] == 'ok'
        result['articles'].each do |article_params|
          create_article(article_params) unless titles.include?(article_params['title'])
        end
      end
      
      clean_up_old_entries

      { timestamp: DateTime.current.strftime("%F %T"), status: :success }
    rescue => e
      { timestamp: DateTime.current.strftime("%F %T"), status: :failure, message: e.message }
    end
  end

  private

  def create_article(params)
    article = Article.new(params.slice('author', 'title', 'description', 'url').symbolize_keys)
    article.source = params['source']['name']
    article.image_url = params['urlToImage']
    article.published_at = params['publishedAt']
    article.save
  end

  def clean_up_old_entries
    last = Article.order(published_at: :desc).limit(20).last
    Article.where('published_at < ?', last.published_at).delete_all
  end
end
