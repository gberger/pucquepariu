class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'basic', null: false
    remove_column :users, :is_admin, :boolean
  end
end
