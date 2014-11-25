class CreateWordDicts < ActiveRecord::Migration
  def change
    create_table :word_dicts do |t|
      t.references :word, index: true
      t.references :dict, index: true

      t.timestamps
    end
  end
end
