require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      create(:article)

      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to eq([
        {
          'id': 1,
          'source': 'News Source',
          'author': 'Author',
          'title': 'Title',
          'description': 'Description',
          'url': 'URL',
          'imageUrl': 'Image URL',
          'publishedAt': '2018-02-16T20:35:37.000Z'
        }
      ].to_json)
    end
  end

  describe 'POST #batch_update' do
    it 'updates article table with fresh news' do
      ENV['NEWS_API_URL'] = 'url'
      ENV['NEWS_API_KEY'] = 'key'
      ENV['ADMIN_TOKEN'] = 'token'
      request.headers.merge!({ 'Authorization' => 'token' })
      result = { timestamp: DateTime.current.strftime("%F %T"), status: :success }

      expect(ArticlesUpdater).to receive(:new).with('urlkey').and_return(ArticlesUpdater.new('urlkey'))
      allow_any_instance_of(ArticlesUpdater).to receive(:execute).and_return(result)

      post :batch_update

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(result.to_json)
    end
  end

end
