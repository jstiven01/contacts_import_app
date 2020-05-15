class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.datetime :birth_date
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :franchise_credit_card
      t.string :email
      t.boolean :is_imported
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
