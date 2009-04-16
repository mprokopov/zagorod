class CreateEditableFeatures < ActiveRecord::Migration
  def self.up
    add_column :lots, :feature1, :string
    add_column :lots, :feature2, :string
    add_column :lots, :feature1name, :string
    add_column :lots, :feature2name, :string
  end

  def self.down
    remove_column :lots, :feature1
    remove_column :lots, :feature2
    remove_column :lots, :feature1name
    remove_column :lots, :feature2name
  end
end
