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
  belongs_to :student

  enum preferred_communication_method: { phone: "phone", email: "email" }

  
  def preferred_contact_info
    case preferred_communication_method
    when "phone"
      self.phone
    when "email"
      self.email
    end
  end
end
