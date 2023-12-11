# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  daily_digest_at        :time
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  lessons_count          :integer          default(0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  students_count         :integer          default(0)
#  timezone               :string           default("Central Time (US & Canada)")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include DailyDigestable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :students, -> { order(first_name: :asc) }, foreign_key: :teacher_id, dependent: :destroy
  has_many :lessons, foreign_key: :teacher_id

  has_many :scheduled_lessons, -> { scheduled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :canceled_lessons, -> { canceled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :taught_lessons, -> { taught.order(starts_at: :desc) }, foreign_key: :teacher_id, class_name: "Lesson"

  has_many :past_lessons, -> { past }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :future_lessons, -> { future }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :todays_lessons, -> { today }, foreign_key: :teacher_id, class_name: "Lesson"

  
  def full_name
    first_name + " " + last_name
  end

  
  def generate_calendar
    calendar = Icalendar::Calendar.new
  

    self.lessons.each do |lesson|
      calendar.event do |e|
        e.dtstart = Icalendar::Values::DateTime.new(lesson.starts_at, "tzid" => "UTC")
        e.dtend = Icalendar::Values::DateTime.new(lesson.ends_at, "tzid" => "UTC")
        e.summary = lesson.canceled? ? "#{lesson.student.full_name} [CANCELED]" : lesson.student.full_name
        e.description = lesson.student.last_lesson.present? ? ActionController::Base.helpers.strip_tags(lesson.student.last_lesson.lesson_notes.to_s) : "No previous lesson notes for this student"
        
        if lesson.student.preferred_communication_method.present?
          
          e.description << "#{lesson.student.default_contact.full_name} #{lesson.student.preferred_communication_method == "phone" ? "#{lesson.student.preferred_contact_info}" : "#{lesson.student.preferred_contact_info}" }"
          
        end

      end
    end

    calendar
  end

end
