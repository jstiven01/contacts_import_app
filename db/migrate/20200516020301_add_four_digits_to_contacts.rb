class AddFourDigitsToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :four_digits, :string
  end
end
