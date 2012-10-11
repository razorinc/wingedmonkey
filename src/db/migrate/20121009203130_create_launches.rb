class CreateLaunches < ActiveRecord::Migration
  def change
    create_table :launches do |t|
      t.string :name
      t.text :details
      t.string :status

      t.timestamps
    end
  end
end
