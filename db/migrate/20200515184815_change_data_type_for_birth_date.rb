class ChangeDataTypeForBirthDate < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :birth_date, :string
  end
end
