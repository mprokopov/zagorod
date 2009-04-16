class CreateNeighbours < ActiveRecord::Migration
  def self.up
    create_table "lots_neighbours", :force => true do |t|
      t.column "lot_id", :integer, :default => 0
      t.column "neighbour_distance_id", :integer, :default => 0
      t.column "neighbour_type_id", :integer, :default => 0
    end

    add_index :lots_neighbours, [:neighbour_distance_id, :neighbour_type_id], 
              :type=>:unique, :name=>'lots_neighbours_index'
  end

  def self.down
    drop_table :lots_neighbours
  end
end
