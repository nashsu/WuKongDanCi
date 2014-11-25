class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :desc
      t.references :dict, index: true

      t.timestamps
    end
  end
end
