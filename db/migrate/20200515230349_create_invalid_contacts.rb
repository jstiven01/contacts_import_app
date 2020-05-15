class CreateInvalidContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :invalid_contacts do |t|
      t.string :name
      t.string :birth_date
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :franchise_credit_card
      t.string :email
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
