#===============================================================================
class Item < ActiveRecord::Base
  before_save     :versioned_save
  after_save      :update_root_id

  #-----------------------------------------------------------------------------
  def to_html
    RedCloth.new(self.content).to_html
  end

  #-----------------------------------------------------------------------------
  def to_metas
    metas = []
    meta = {}
    self.content.scan(/(\S+)\s*:\s*(\S+)/) do |raw_name, raw_value|
      name = raw_name.tr("_", " ").strip.upcase
      value = raw_value.tr("_", " ").strip
      if name=="-" && value=="-"
        metas << meta
        meta = {}
      else
        meta[name] = value
      end
    end
    return metas
  end

  #-----------------------------------------------------------------------------
  def destroy
    self.update_attribute(:deleted, true)
    freeze
  end

 #-----------------------------------------------------------------------------
  private
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  def versioned_save
    if self.new_record? || !self.version? 
      self.version ||= 1
      self.deleted = false
    else
      unless self.changes['first_id'] || self.deleted
        new = self.clone
        self.reload
        self.deleted = true
        new.version = self.version + 1
        new.save
        puts self.inspect
        puts new.inspect
      end
    end
    return true
  end

  #-----------------------------------------------------------------------------
  def update_root_id
    self.update_attribute(:first_id, self.id) unless self.first_id?
    return true
  end

end
