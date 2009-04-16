class CreateNeighbourDistances < ActiveRecord::Migration
  def self.up
    create_table :neighbour_distances do |t|
      t.column "distance", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :neighbour_distances
  end
end
