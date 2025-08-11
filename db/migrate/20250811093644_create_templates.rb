class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.json :signature
      t.text :content

      t.timestamps
    end
  end
end
