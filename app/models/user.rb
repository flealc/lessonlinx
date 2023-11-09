# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  daily_digest           :time
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  lessons_count          :integer          default(0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  students_count         :integer          default(0)
#  timezone               :string
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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :students, -> { order(first_name: :asc) }, foreign_key: :teacher_id
  has_many :lessons, foreign_key: :teacher_id

  has_many :scheduled_lessons, -> { scheduled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :canceled_lessons, -> { canceled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :taught_lessons, -> { taught.order(starts_at: :desc) }, foreign_key: :teacher_id, class_name: "Lesson"

  has_many :past_lessons, -> { past }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :future_lessons, -> { future }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :todays_lessons, -> { today }, foreign_key: :teacher_id, class_name: "Lesson"

  scope :signed_up_for_daily_digest, -> { where.not(daily_digest: nil) }

  # TODO: include DailyDigestable

 
  def full_name
    first_name + " " + last_name
  end

  
  # TODO: move to concern User::DailyDigestable
  def self.schedule_daily_digest
    
    User.signed_up_for_daily_digest.each do |user|
      send_at = DateTime.now.change(hour:user.daily_digest.hour, min: user.daily_digest.min).in_time_zone(user.timezone).utc
      send_at += 1.day if send_at.past?

      if user.lessons.today.any?

        Rails.logger.info "Scheduling daily digest for User: #{user.first_name}: ID: #{user.id} at #{send_at}"
        UserMailer.daily_digest(user).deliver_later(wait_until: send_at) 
     
      else

        Rails.logger.info "No lessons today for User: #{user.first_name}: ID: #{user.id} - no email sent."

      end

    end
  end
  
  def generate_calendar
    calendar = Icalendar::Calendar.new

    self.lessons.each do |lesson|
      calendar.event do |e|
        e.dtstart = lesson.starts_at
        e.dtend = lesson.ends_at
        e.summary = lesson.canceled? ? "#{lesson.student.full_name} [CANCELED]" : lesson.student.full_name
        e.description = lesson.student.last_lesson.present? ? lesson.student.last_lesson.lesson_notes : "No previous lesson notes for this student"
      end
    end

    calendar
  end

end
