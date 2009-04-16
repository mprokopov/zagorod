class CreateElectricities < ActiveRecord::Migration
  def self.up
    create_table :electricities do |t|
      t.column "distance", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :electricities
  end
end
