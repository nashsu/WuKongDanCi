json.array!(@words) do |word|
  json.extract! word, :id, :content, :mean, :w_type, :phonetic
  json.url word_url(word, format: :json)
end
