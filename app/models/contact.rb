# == Schema Information
#
# Table name: contacts
#
#  id                             :uuid             not null, primary key
#  address                        :text
#  email                          :string
#  first_name                     :string
#  last_name                      :string
#  notes                          :text
#  phone                          :string
#  preferred_communication_method :string
#  relationship                   :string           default("self")
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  student_id                     :uuid             not null
#
# Indexes
#
#  index_contacts_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class Contact < ApplicationRecord
  before_save :name_if_self
  belongs_to :student

  enum preferred_communication_method: { phone: "phone", email: "email" }

  
  def full_name
    first_name + " " + last_name
  end

  def preferred_contact_info
    case preferred_communication_method
    when "phone"
      self.phone
    when "email"
      self.email
    end
  end

  def default?
    self.student.default_contact_id == self.id
  end

  private

  def name_if_self
    if self.relationship == "self"
      self.first_name = self.student.first_name
      self.last_name = self.student.last_name
    end
  end
end
