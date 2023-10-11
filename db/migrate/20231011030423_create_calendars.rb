class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars, id: :uuid do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
