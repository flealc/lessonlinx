# == Schema Information
#
# Table name: calendars
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid             not null
#
# Indexes
#
#  index_calendars_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Calendar < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :lessons
  
end
