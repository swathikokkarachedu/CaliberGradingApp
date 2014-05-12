class AddFieldsToStudent < ActiveRecord::Migration
  def change
   add_column :students, :grade, :string
   add_column :students, :comment, :text
   add_column :students, :lab_id, :integer
  end
end
