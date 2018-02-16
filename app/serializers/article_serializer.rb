class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :source, :author, :title, :description, :url, :image_url, :published_at
end
