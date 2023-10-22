class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :age
      t.boolean :adult, default: false
      t.references :teacher, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.integer :lessons_count, default: 0
      t.timestamps
    end
  end
end