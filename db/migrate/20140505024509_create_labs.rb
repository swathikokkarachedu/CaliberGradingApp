class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.integer :course_id
      t.integer :total_marks
      t.string :due_date

      t.timestamps
    end
  end
end
