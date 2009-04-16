class CreateDepartures < ActiveRecord::Migration
  def self.up
    create_table :departures do |t|
      t.column "departure", :string, :limit => 200, :default => "", :null => false
      t.column "xpoint", :integer, :default => 0, :null => false
      t.column "ypoint", :integer, :default => 0, :null => false
      t.column "image", :string, :limit => 150, :default => "", :null => false
      t.column "image2", :string, :limit => 150, :default => "", :null => false
      t.column "title", :string, :limit => 150, :default => "", :null => false
      t.column "name", :string, :limit => 150, :default => "", :null => false
    end
  end

  def self.down
    drop_table :departures
  end
end
