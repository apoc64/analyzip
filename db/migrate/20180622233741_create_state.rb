class CreateState < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :abbreviation
      t.string :name

      t.timestamps
    end
  end
end
