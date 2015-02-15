class ChangeNews < ActiveRecord::Migration
  def up
    remove_column :news, :image
    remove_column :news, :chinese_title
    remove_column :news, :chinese_content
    change_column :news, :title, :string, null: false

    add_column :news, :news_locale, :string, null: false
    add_column :news, :index_id, :integer, null: false
    add_index :news, [:index_id, :news_locale], unique: true
  end

  def down
    add_column :news, :image, :string
    add_column :news, :chinese_title, :text, null: false
    add_column :news, :chinese_content, :text, null: false
    change_column :news, :title, :text, null: false

    remove_index :news, [:index_id, :news_locale]
    remove_column :news, :news_locale
    remove_column :news, :index_id
  end
end
