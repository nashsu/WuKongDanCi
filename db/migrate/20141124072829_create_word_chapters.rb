class CreateWordChapters < ActiveRecord::Migration
  def change
    create_table :word_chapters do |t|
      t.references :word, index: true
      t.references :chapter, index: true

      t.timestamps
    end
  end
end
