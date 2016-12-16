class AddNamesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :personal_name, :string
    add_column :users, :business_name, :string

    remove_column :users, :name, :string
  end
end
