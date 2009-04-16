class CreateNatureDistances < ActiveRecord::Migration
  def self.up
    create_table :nature_distances do |t|
      t.column "distance", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :nature_distances
  end
end
