class CreateNoiseSources < ActiveRecord::Migration
  def self.up
    create_table :noise_sources do |t|
      t.column "source", :string, :limit => 150, :default => "", :null => false
    end
    create_table "lots_noise_sources", :id => false, :force => true do |t|
      t.column "lot_id", :integer, :default => 0, :null => false
      t.column "noise_source_id", :integer, :default => 0, :null => false
    end
    add_index :lots_noise_sources, [:lot_id, :noise_source_id], :type=>:unique, :name=>'lots_noise_sources_index'
  end

  def self.down
    drop_table :noise_sources
    drop_table :lots_noise_sources
  end
end
