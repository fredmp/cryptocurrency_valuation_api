FactoryBot.define do
  factory :article do
    source 'News Source'
    author 'Author'
    title 'Title'
    description 'Description'
    url 'URL'
    image_url 'Image URL'
    published_at DateTime.parse('2018-02-16T20:35:37.000Z')
  end
end
