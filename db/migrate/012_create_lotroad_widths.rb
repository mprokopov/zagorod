class CreateLotroadWidths < ActiveRecord::Migration
  def self.up
    create_table :lotroad_widths do |t|
      t.column "width", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :lotroad_widths
  end
end
