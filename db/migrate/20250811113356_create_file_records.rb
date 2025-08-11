class CreateFileRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :file_records do |t|
      t.string :name
      t.string :file
      t.string :status

      t.timestamps
    end
  end
end
