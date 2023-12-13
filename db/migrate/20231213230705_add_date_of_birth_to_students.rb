class AddDateOfBirthToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :date_of_birth, :date
    remove_column :students, :age
  end
end
