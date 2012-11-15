class RenameLaunchesToLaunchables < ActiveRecord::Migration
  def up
    rename_table :launches, :launchables
  end

  def down
    rename_table :launchables, :launches
  end
end
