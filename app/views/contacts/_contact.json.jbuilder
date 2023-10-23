json.extract! contact, :id, :first_name, :last_name, :student_id, :phone, :email, :address, :relationship, :preferred_communication_method, :notes, :created_at, :updated_at
json.url contact_url(contact, format: :json)
