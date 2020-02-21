class CreateKigurumis < ActiveRecord::Migration[5.2]
  def change
    create_table :kigurumis do |t|
      t.references :characer
      t.references :factory
      t.references :customizer
      t.references :base_type
      t.references :owner
      t.references :previous_owner

      t.timestamps
    end
  end
end
