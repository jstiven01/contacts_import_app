class AddErrorDesctoInvalidContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :invalid_contacts, :error_desc, :string
  end
end
