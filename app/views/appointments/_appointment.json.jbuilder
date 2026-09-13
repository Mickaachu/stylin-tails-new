json.extract! appointment, :id, :service, :date_time, :pet_id, :owner_id, :cost, :status, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
