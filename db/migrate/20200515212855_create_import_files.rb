class CreateImportFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :import_files do |t|
      t.string :name
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
