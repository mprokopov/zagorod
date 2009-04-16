class CreateNeighbourTypes < ActiveRecord::Migration
  def self.up
    create_table :neighbour_types do |t|
      t.column "neighbour", :string, :limit => 200, :default => "", :null => false
      t.column "has_distance", :integer, :default => "1", :null => false
    end
  end

  def self.down
    drop_table :neighbour_types
  end
end
