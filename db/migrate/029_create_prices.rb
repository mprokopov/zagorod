class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.column "price", :string, :limit => 100, :default => "0", :null => false
      t.column "min_price", :float, :default => 0.0, :null => false
      t.column "max_price", :float, :default => 0.0, :null => false
    end
  end

  def self.down
    drop_table :prices
  end
end
