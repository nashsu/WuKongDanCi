json.array!(@dicts) do |dict|
  json.extract! dict, :id, :name, :desc
  json.url dict_url(dict, format: :json)
end
