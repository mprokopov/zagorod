class CreateNoises < ActiveRecord::Migration
  def self.up
    create_table :noises do |t|
      t.column "noise", :string, :limit => 150, :default => "", :null => false
    end
  end

  def self.down
    drop_table :noises
  end
end
