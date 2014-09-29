class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string  :name
      t.string  :password
      t.string  :salt
      t.string  :title
      t.string  :phone
      t.string  :image
      t.text    :description
      t.timestamps
    end
  end
end
