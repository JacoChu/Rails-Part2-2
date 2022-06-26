class AddRowOrderToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :row_order, :integer
    Event.find_each do |e|
      e.update( :row_order => :last )
    end
    
    add_index :events, :row_order
  end
end
