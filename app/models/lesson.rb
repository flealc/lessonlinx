# == Schema Information
#
# Table name: lessons
#
#  id           :uuid             not null, primary key
#  duration     :integer          not null
#  ends_at      :datetime         not null
#  lesson_notes :text
#  starts_at    :datetime         not null
#  status       :string           default("scheduled"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  student_id   :uuid             not null
#  teacher_id   :uuid             not null
#
# Indexes
#
#  index_lessons_on_student_id  (student_id)
#  index_lessons_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#  fk_rails_...  (teacher_id => users.id)
#
class Lesson < ApplicationRecord
  before_create :set_datetime, :set_teacher
  
  belongs_to :teacher, class_name: "User", counter_cache: true
  belongs_to :student, counter_cache: true

  enum status: { scheduled: "scheduled", taught: "taught", canceled: "canceled" } 

  scope :default_order, -> { order(starts_at: :asc) }
  scope :future, ->{ where("starts_at > ?", Time.current).order(starts_at: :asc) }
  scope :past, ->{ where("starts_at < ?", Time.current).order(starts_at: :desc) }
  scope :this_week, -> { where(starts_at: Date.today.beginning_of_week..Date.today.end_of_week)}

  # TODO: move to Lesson::Ransackable concern
  def self.ransackable_attributes(auth_object=nil)
    [
      "future",
      "past"
    ]
  end


  def self.ransackable_scopes(auth_object=nil)
    %i[default_order past future]
  end


  private

  def set_datetime
    self.starts_at = self.starts_at.in_time_zone
    self.ends_at = self.starts_at + duration.minutes
  end

  def set_teacher 
    self.teacher_id ||= current_user.id
  end
  
end
