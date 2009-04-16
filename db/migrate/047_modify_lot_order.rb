class ModifyLotOrder < ActiveRecord::Migration
  def self.up
    # вес участка, для сортировки по умолчанию
    add_column("lots","weights", :integer, :default=>'0')
  end

  def self.down
    remove_column "lots","weights"
  end
end
