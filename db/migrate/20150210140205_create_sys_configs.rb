class CreateSysConfigs < ActiveRecord::Migration
  def change
    create_table :sys_configs do |t|
      t.string :name, null: false
      t.string :value, null: false
    end
  end
end
