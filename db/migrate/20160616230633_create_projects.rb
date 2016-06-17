class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :environment
      t.string :test_command
      t.string :deploy_command

      t.timestamps null: false
    end
  end
end
