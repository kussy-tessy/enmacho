class CreateBases < ActiveRecord::Migration[5.2]
  def change
    create_table :bases do |t|
      t.references :factory
      t.string :name

      t.timestamps
    end
  end
end
