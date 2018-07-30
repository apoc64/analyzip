class CreateUserZips < ActiveRecord::Migration[5.2]
  def change
    create_table :user_zips do |t|
      t.string :comment
      t.references :zip, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
