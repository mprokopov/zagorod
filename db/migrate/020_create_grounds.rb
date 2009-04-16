class CreateGrounds < ActiveRecord::Migration
  def self.up
    create_table :grounds do |t|
      t.column "ground", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :grounds
  end
end
