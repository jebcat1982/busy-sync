class AddBusinessInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :personal_image, :string
    add_column :users, :personal_email, :string
    add_column :users, :business_image, :string
    add_column :users, :business_email, :string

    remove_column :users, :image, :string
  end
end
