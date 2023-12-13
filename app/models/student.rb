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
  validates :first_name, presence: true
  validate :valid_date_of_birth
  before_destroy :clear_default_contact
  
  belongs_to :teacher, class_name: "User", counter_cache: true
  has_many :contacts, dependent: :destroy
  has_one :default_contact, class_name: 'Contact', primary_key: 'default_contact_id', foreign_key: 'id'
  has_many :lessons, dependent: :destroy
  
  has_many :scheduled_lessons, -> { scheduled }, class_name: "Lesson"
  has_many :canceled_lessons, -> { canceled }, class_name: "Lesson"
  has_many :taught_lessons, -> { taught }, class_name: "Lesson"
  
  has_many :past_lessons, -> { past }, class_name: "Lesson"
  has_many :future_lessons, -> { future }, class_name: "Lesson"
  has_one :upcoming_lesson, -> { future.scheduled }, class_name: "Lesson"
  has_one :last_lesson, -> { past }, class_name: "Lesson"
  
  delegate :preferred_communication_method, :preferred_contact_info, to: :default_contact, allow_nil: true
  
  def full_name
    first_name + " " + last_name
  end
  
  def set_default_contact(contact)
    if self.contacts.include?(contact)
      self.default_contact_id = contact.id
    end
    save
  end
  
  private
  
  def valid_date_of_birth
    return if date_of_birth.blank?
    
    unless date_of_birth.is_a?(Date)
      errors.add(:date_of_birth, 'is invalid')
    end
  
    if date_of_birth > Date.today
      errors.add(:date_of_birth, 'is invalid')
    end
    
    if date_of_birth.year < 1900
      errors.add(:date_of_birth, 'is invalid')
    end
  end

  def clear_default_contact
    update_column(:default_contact_id, nil)
  end
  
end
