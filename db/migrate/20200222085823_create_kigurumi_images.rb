class CreateKigurumiImages < ActiveRecord::Migration[5.2]
  def change
    create_table :kigurumi_images do |t|
      t.references :kigurumi
      t.string :url

      t.timestamps
    end
  end
end
