json.extract! lesson, :id, :calendar_id, :teacher_id, :student_id, :date, :start_time, :duration, :status, :lesson_notes, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
