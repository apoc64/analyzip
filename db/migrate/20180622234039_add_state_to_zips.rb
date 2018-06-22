class AddStateToZips < ActiveRecord::Migration[5.2]
  def change
    add_reference :zips, :state, foreign_key: true
  end
end
