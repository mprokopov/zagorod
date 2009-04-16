class CreateWaters < ActiveRecord::Migration
  def self.up
    create_table :waters do |t|
      t.column "object", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :waters
  end
end
