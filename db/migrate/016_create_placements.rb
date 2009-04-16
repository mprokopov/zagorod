class CreatePlacements < ActiveRecord::Migration
  def self.up
    create_table :placements do |t|
      t.column "placement", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :placements
  end
end
