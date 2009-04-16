class CreateAgencies < ActiveRecord::Migration
  def self.up
    create_table :agencies do |t|
      t.column "fio", :string, :limit=>200, :default=>""
      t.column "name", :string, :limit=>200, :default=>""
      t.column "address", :string, :limit=>200, :default=>""
      t.column "phone1", :string, :limit=>100, :default=>""
      t.column "phone2", :string, :limit=>100, :default=>""
      t.column "email", :string, :limit=>200
      t.column "created_on", :timestamp
      t.column "updated_on", :timestamp
    end
  end

  def self.down
    drop_table :agencies
  end
end
