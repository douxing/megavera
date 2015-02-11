class ChangeValueOfSysConfig < ActiveRecord::Migration
  def change
    change_column :sys_configs, :value, :text
  end
end
