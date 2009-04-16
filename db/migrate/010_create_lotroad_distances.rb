class CreateLotroadDistances < ActiveRecord::Migration
  def self.up
    create_table :lotroad_distances do |t|
      t.column "distance", :string, :limit => 150, :default => "", :null => false
    end
  end

  def self.down
    drop_table :lotroad_distances
  end
end
