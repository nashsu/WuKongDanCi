class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.string :mean
      t.string :w_type
      t.string :phonetic

      t.timestamps
    end
  end
end
