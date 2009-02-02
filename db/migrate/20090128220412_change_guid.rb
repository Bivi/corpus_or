#===============================================================================
class ChangeGuid < ActiveRecord::Migration

  #-----------------------------------------------------------------------------
  def self.up
    remove_column :items, :guid
    add_column    :items, :first_id, :integer 
  end

  #-----------------------------------------------------------------------------
  def self.down
    add_column    :items, :guid, :string
    remove_column :items, :first_id
  end
end
