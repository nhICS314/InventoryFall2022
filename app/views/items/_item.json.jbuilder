json.extract! item, :id, :name, :price, :description, :sku, :count, :deletedComment, :created_at, :updated_at
json.url item_url(item, format: :json)
