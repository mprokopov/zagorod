class CreateSquares < ActiveRecord::Migration
  def self.up
    create_table :squares do |t|
      t.column "square", :string, :limit => 100, :default => "", :null => false
      t.column "min_square", :float, :default => 0.0, :null => false
      t.column "max_square", :float, :default => 0.0, :null => false
    end
  end

  def self.down
    drop_table :squares
  end
end
