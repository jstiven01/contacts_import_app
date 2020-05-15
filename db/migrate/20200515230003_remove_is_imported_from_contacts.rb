class RemoveIsImportedFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :is_imported, :boolean
  end
end
