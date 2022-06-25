class RemoveColumnToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :friendly_id
  end
end
