class CreateNatureTypes < ActiveRecord::Migration
  def self.up
    create_table :nature_types do |t|
      t.column "nature", :string, :limit => 200, :default => "", :null => false
      t.column "has_distance", :integer, :default=>"1",:null=>false
    end
    add_index "nature_types", ["has_distance"], :name=>"has_distance" 
  end

  def self.down
    drop_table :nature_types
  end
end
