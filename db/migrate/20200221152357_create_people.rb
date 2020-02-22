class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :other_name
      t.string :yomigana
      t.integer :birth_year
      t.boolean :birth_is_reliable
      t.date :birthday
      t.references :home_prefecture, optional: true
      t.references :prefecture, optional: true
      t.string :twitter
      t.boolean :lives_with_parents
      t.boolean :is_student
      t.text :remarks

      t.timestamps
    end
  end
end
