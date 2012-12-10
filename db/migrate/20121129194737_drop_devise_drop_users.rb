class DropDeviseDropUsers < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    # not gonna recreate the table
    # if we bring users back later, we'll simply have another migration for the
    # create_table
  end
end
