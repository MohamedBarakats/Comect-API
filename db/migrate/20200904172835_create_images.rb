class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :tag
      t.string :trend
      t.text :description

      t.timestamps
    end
  end
end
