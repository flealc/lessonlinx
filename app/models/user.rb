# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  calendars_count        :integer          default(0)
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

  has_many :calendars, foreign_key: :owner_id
  has_many :students, foreign_key: :teacher_id
  has_many :lessons, foreign_key: :teacher_id

  has_many :scheduled_lessons, -> { scheduled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :canceled_lessons, -> { canceled }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :taught_lessons, -> { taught }, foreign_key: :teacher_id, class_name: "Lesson"

  has_many :past_lessons, -> { past }, foreign_key: :teacher_id, class_name: "Lesson"
  has_many :future_lessons, -> { future }, foreign_key: :teacher_id, class_name: "Lesson"


  def full_name
    first_name + " " + last_name
  end
  
end
