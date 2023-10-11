# == Schema Information
#
# Table name: lessons
#
#  id           :uuid             not null, primary key
#  date         :date             not null
#  duration     :integer          not null
#  lesson_notes :text
#  start_time   :time             not null
#  status       :string           default("scheduled"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  calendar_id  :uuid             not null
#  student_id   :uuid             not null
#  teacher_id   :uuid             not null
#
# Indexes
#
#  index_lessons_on_calendar_id  (calendar_id)
#  index_lessons_on_student_id   (student_id)
#  index_lessons_on_teacher_id   (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (calendar_id => calendars.id)
#  fk_rails_...  (student_id => students.id)
#  fk_rails_...  (teacher_id => users.id)
#
class Lesson < ApplicationRecord
  belongs_to :calendar
  belongs_to :teacher, class_name: "User", counter_cache: true
  belongs_to :student

  enum status: { scheduled: "scheduled", taught: "taught", canceled: "canceled" } 

  scope :future, -> { where('date > ? AND starting_time > ?', Date.current, Time.current) }
  scope :past, -> { where('date < ? OR starting_time < ?', Date.current, Time.current) }
end
