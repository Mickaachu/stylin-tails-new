json.extract! owner, :id, :full_name, :phone, :email, :pet_id, :created_at, :updated_at
json.url owner_url(owner, format: :json)
