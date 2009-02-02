#===============================================================================
class CreateItems < ActiveRecord::Migration
  #-----------------------------------------------------------------------------
  def self.up
    create_table :items do |t|
      t.string :guid
      t.text :content
      t.integer :version
      t.boolean :deleted

      t.timestamps
    end
  end

  #-----------------------------------------------------------------------------
  def self.down
    drop_table :items
  end

end
