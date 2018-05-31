class CreateStatusCategories < ActiveRecord::Migration
  def change
    create_table :status_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
