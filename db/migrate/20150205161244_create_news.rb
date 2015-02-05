class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title, null: false
      t.text :content, null: false
      t.text :chinese_title, null: false
      t.text :chinese_content, null: false

      t.timestamps
    end
  end
end
