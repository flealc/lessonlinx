class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.references :student, null: false, foreign_key: { to_table: :students }, type: :uuid
      t.string :phone
      t.string :email
      t.text :address
      t.string :relationship
      t.string :preferred_communication_method
      t.text :notes

      t.timestamps
    end
  end
end
