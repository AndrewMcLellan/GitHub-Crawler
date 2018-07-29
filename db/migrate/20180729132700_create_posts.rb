class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.string :description
      t.belongs_to :language

      t.timestamps null: false 
    end
  end
end
