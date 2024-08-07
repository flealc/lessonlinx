class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons, id: :uuid do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :student, null: false, foreign_key: { to_table: :students }, type: :uuid
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.integer :duration, null: false
      t.string :status, null: false, default: "scheduled"
      t.timestamps
    end
  end
end
