class CreateReciteTasks < ActiveRecord::Migration
  def change
    create_table :recite_tasks do |t|
      t.integer :task_type
      t.text :word_ids
      t.references :user, index: true
      t.datetime :start_time
      t.datetime :next_time

      t.timestamps
    end
  end
end
