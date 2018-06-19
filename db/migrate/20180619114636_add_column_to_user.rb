class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_confirmation, :boolean, default: false
  end
end
