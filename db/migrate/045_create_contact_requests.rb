class CreateContactRequests < ActiveRecord::Migration
  def self.up
    create_table :contact_requests do |t|
      t.column :name, :string
      t.column :phone, :string
      t.column :email, :string
      t.column :lot_id, :integer, :default => 0, :null => false
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :contact_requests
  end
end
