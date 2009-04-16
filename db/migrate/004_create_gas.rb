class CreateGas < ActiveRecord::Migration
  def self.up
    create_table :gas do |t|
      t.column "distance", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :gas
  end
end
