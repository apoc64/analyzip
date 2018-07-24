class AddStateToCounties < ActiveRecord::Migration[5.2]
  def change
    add_reference :counties, :state, foreign_key: true
  end
end
