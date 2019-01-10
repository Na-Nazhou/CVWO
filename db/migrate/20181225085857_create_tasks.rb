class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.boolean :completed, default: false
      t.string :title
      t.text :description
      t.datetime :deadline
      t.string :tag
      t.references :user

      t.timestamps
    end
  end
end
