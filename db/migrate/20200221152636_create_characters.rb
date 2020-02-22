class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.references :work, optional: true
      t.string :name

      t.timestamps
    end
  end
end
