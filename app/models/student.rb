# == Schema Information
#
# Table name: students
#
#  id            :uuid             not null, primary key
#  adult         :boolean          default(FALSE)
#  age           :integer
#  first_name    :string           not null
#  last_name     :string           not null
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  teacher_id    :uuid             not null
#
# Indexes
#
#  index_students_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class Student < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_many :contacts
  has_many :lessons
end
