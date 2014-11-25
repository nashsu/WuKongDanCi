class CreateReciteWords < ActiveRecord::Migration
  def change
    create_table :recite_words do |t|
      t.references :recite_task, index: true
      t.references :word, index: true
      t.references :user, index: true
      t.integer :score
      t.references :dict, index: true

      t.timestamps
    end
  end
end
