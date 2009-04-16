class CreatePages < ActiveRecord::Migration
  def self.up
    create_table "pages", :force => true do |t|
      t.column "parent_id", :integer,:default => "0"
      t.column "url", :string
      t.column "text", :text
      t.column "is_published", :integer, :limit => 4
      t.column "in_top_menu", :string, :limit => 0, :default => ""
      t.column "has_left_menu", :integer, :default => "0"
      t.column "title", :string
      t.column "preview", :text
      t.column "keywords", :text, :default => "", :null => false
      t.column "description", :text, :default => "", :null => false
    end
    add_index :pages, [:parent_id], :type=>:unique, :name=>'page_parent_id'
  end

  def self.down
    drop_table :pages
  end
end
