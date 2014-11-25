class AddColumnToReciteTask < ActiveRecord::Migration
  def change
  	add_column :recite_tasks, :tmp_record, :text
  end
end
