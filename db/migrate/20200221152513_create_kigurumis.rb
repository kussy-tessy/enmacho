class CreateKigurumis < ActiveRecord::Migration[5.2]
  def change
    create_table :kigurumis do |t|
      t.references :character
      t.references :factory, optional: true
      t.references :customizer, optional: true
      t.references :base, optional: true
      t.references :owner, optional: true
      t.references :previous_owner, optional: true
      t.text :remarks, optional: true
      t.integer :show_year, optional: true
      t.integer :hair_color, optional: true
      t.integer :hair_length, optional: true
      t.integer :mouth_open, optional: true

      t.timestamps
    end
  end
end
