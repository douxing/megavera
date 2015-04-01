class CreateSlogans < ActiveRecord::Migration
  def change
    create_table :slogans do |t|
      t.string :author, null: false
      t.column :content, :text, null: false
    end
  end
end
