class DropLaunchablesTable < ActiveRecord::Migration
  def up
    drop_table :launchables
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
