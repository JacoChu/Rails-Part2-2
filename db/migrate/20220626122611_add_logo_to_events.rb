class AddLogoToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :logo, :string
  end
end
