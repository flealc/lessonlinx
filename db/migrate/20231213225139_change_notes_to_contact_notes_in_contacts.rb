class ChangeNotesToContactNotesInContacts < ActiveRecord::Migration[7.0]
  def change
    rename_column :contacts, :notes, :contact_notes
  end
end
