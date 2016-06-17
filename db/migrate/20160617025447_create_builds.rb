class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name
      t.string :commit
      t.integer :project_id
      t.boolean :build_status
      t.string :build_output
      t.boolean :test_status
      t.string :test_output
      t.boolean :deployment_status
      t.string :deployment_output

      t.timestamps null: false
    end
  end
end
