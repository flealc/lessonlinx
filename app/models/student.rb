# == Schema Information
#
# Table name: students
#
#  id                 :uuid             not null, primary key
#  adult              :boolean          default(FALSE)
#  age                :integer
#  first_name         :string           not null
#  last_name          :string           not null
#  lessons_count      :integer          default(0)
#  student_notes      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  default_contact_id :uuid
#  teacher_id         :uuid             not null
#
# Indexes
#
#  index_students_on_default_contact_id  (default_contact_id)
#  index_students_on_teacher_id          (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (default_contact_id => contacts.id)
#  fk_rails_...  (teacher_id => users.id)
#
class Student < ApplicationRecord
  belongs_to :teacher, class_name: "User",  counter_cache: true
  has_many :contacts
  has_one :default_contact, class_name: "Contact", required: false
  has_many :lessons

  has_many :scheduled_lessons, -> { scheduled }, class_name: "Lesson"
  has_many :canceled_lessons, -> { canceled }, class_name: "Lesson"
  has_many :taught_lessons, -> { taught }, class_name: "Lesson"

  has_many :past_lessons, -> { past }, class_name: "Lesson"
  has_many :future_lessons, -> { future }, class_name: "Lesson"
  has_one :upcoming_lesson, -> { future }, class_name: "Lesson"
  
  delegate :preferred_communication_method, :preferred_contact_info, to: :default_contact, allow_nil: true
  

  def full_name
    first_name + " " + last_name
  end

end
