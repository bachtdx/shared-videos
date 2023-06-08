class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :shared_video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :like

      t.timestamps
    end
  end
end
