class CreateRouteTypes < ActiveRecord::Migration
  def self.up
    create_table :route_types do |t|
      t.column "route", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :route_types
  end
end
