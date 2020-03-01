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

      t.timestamps
    end
  end
end
