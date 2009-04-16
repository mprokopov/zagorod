class CreateOwners < ActiveRecord::Migration
  def self.up
    create_table :owners do |t|
      t.column "fio", :string, :limit=>200, :default=>""
      t.column "phone_city", :string, :limit=>200,:default=>""
      t.column "phone", :string, :limit=>200,:default=>""
      t.column "another_contact_fio", :string, :limit=>200
      t.column "another_contact_phone", :string, :limit=>200
      t.column "email", :string, :limit=>200
      t.column "created_on", :timestamp
      t.column "updated_on", :timestamp
      t.column "is_other_contacts_allowed", :integer, :default=>0, :null=>false
      t.column "preferred_contact_type", :string, :limit=>100
    end
  end

  def self.down
    drop_table :owners
  end
end
