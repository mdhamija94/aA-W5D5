class AddColumnToVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :visits, :url_id, :integer, null: false
  end
end
